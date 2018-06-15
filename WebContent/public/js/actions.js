/*
 * 
 * 增、删、改动作处理类
 */
var Actions = function Actions(options) {
    this.setOptions(options);
};

Actions.prototype = {
    /**
     * options:Actions类的属性
     * url:请求连接
     * param:请求参数
     * resultKey:返回json中获取结果的Key,如：{result:"success"}
     * tipKey:返回json中获取提示语的Key,如：{result:"success",tip:"新增成功！"}
     * successDiv:成功提示框的id
     * failedDiv:失败提示框的id
     * successCallBack:操作成功后执行的function
     * failedCallBack:操作失败后执行的function
     */
    options:{
        url:"",
        param:"",
        resultKey:"result",
        tipKey:"tip",
        successDiv:"#successTip",
        failedDiv:"#failedTip",
        successCallBack:function() {},
        failedCallBack:function() {}
    },
    /**
     * 设置属性
     * @param options
     */
    setOptions:function(options) {
        this.options = $.extend({}, this.options, options);
    },
    /**
     * 提交请求
     * @param options
     */
    submit:function(options) {
        this.setOptions(options);
        var self = this;
        $.post(this.options.url, this.options.param, function(data) {
            var result = data[self.options.resultKey];
            var tip = data[self.options.tipKey];
            if (result == "success" && $.trim(tip).length > 0) {
                $(self.options.successDiv).html(tip);
                $(self.options.successDiv).slideDown();
                window.setTimeout(function() {
                    $(self.options.successDiv).slideUp();
                }, 3e3);
                if (typeof self.options.successCallBack === "function") self.options.successCallBack();
            } else if ($.trim(tip).length > 0) {
                $(self.options.failedDiv).html(tip);
                $(self.options.failedDiv).slideDown();
                window.setTimeout(function() {
                    $(self.options.failedDiv).slideUp();
                }, 3e3);
                if (typeof self.options.failedCallBack === "function") self.options.failedCallBack();
            }
        });
    }
};

/*
 * 弹框处理类
 */
var Alert = function Alert(options) {
    this.init(options);
};

Alert.prototype = {
    /**
     * options:Alert类的属性
     * checkTable:检验的table的
     * alertDiv:弹框
     * validateForm:需校验的form表单
     * needSelected:是否需要验证至少选择一项
     * needConfirm:是否需要确认提示
     * needValidate：是否需要验证form表单
     * validataFlag:表单验证结果
     * showActionTip:是否显示动作提示
     * headerTip:提示框标题
     * confirmTip:确认提示信息
     * actionTip:动作提示信息
     * confrimAction:确认动作对应的function
     */
    options:{
        checkTable:"",
        alertDiv:"#alertDialog",
        validateForm:"#form",
        needSelected:true,
        needConfirm:true,
        needValidate:false,
        showActionTip:false,
        headerTip:tip_message.warning,
        confirmTip:tip_message.confirm_del,
        actionTip:"",
        confirmAction:function() {}
    },
    /**
     * 初始化函数
     * 获取弹框的各模块并绑定相关事件
     * @param options
     */
    init:function(options) {
        this.setOptions(options);
        this.$alertDialog = $(this.options.alertDiv);
        this.$alertHeader = this.$alertDialog.find(".modal-header h4");
        this.$alertContent = this.$alertDialog.find(".modal-body");
        this.$alertFooter = this.$alertDialog.find(".modal-footer");
        var self = this;
        this.$alertDialog.find(".modal-footer button.btn-default").click(function() {
            self.cancel();
        });
        this.$alertDialog.find(".modal-footer button.btn-primary").click(function() {
            self.confirm();
        });
    },
    /**
     * 设置相关属性
     * @param options
     */
    setOptions:function(options) {
        this.options = $.extend({}, this.options, options);
    },
    /**
     * 执行弹框动作
     * @param options
     */
    check:function(options) {
        this.setOptions(options);
        this.$checkboxs = $(this.options.checkTable).find("tbody td input[type='checkbox']:checked");
        if (this.options.needSelected && this.$checkboxs.length === 0) {
            //需要至少选择一项且一项都没选择
            this.actionFlag = false;
            this.$alertDialog.find(".modal-dialog").width(380);
            this.$alertContent.css("padding", "20px");
            this.$alertHeader.html(tip_message.warning);
            this.$alertContent.html(tip_message.select_at_least_one);
            this.$alertFooter.show();
            this.$alertDialog.modal("show");
        } else {
            //不需要至少选择一项或者已选择选项
            this.actionFlag = true;
            if (this.options.needConfirm) {
                //需要弹出确认提示
                this.$alertHeader.html(this.options.headerTip);
                this.$alertContent.html(this.options.confirmTip);
                this.$alertFooter.show();
                this.$alertDialog.modal("show");
            } else {
                //不需要确认提示
                this.confirm();
            }
        }
    },
    confirm:function() {
        if (this.actionFlag && typeof this.options.confirmAction === "function") {
            if (this.options.needConfirm && this.options.needValidate) {
                var formObj = $(this.options.validateForm).inputValid(valid_message_options);
                if (formObj.validate_all()) {
                    this.options.confirmAction(this.$checkboxs);
                    this.cancel();
                } else return;
            } else {
                this.options.confirmAction(this.$checkboxs);
                this.cancel();
                if (this.options.showActionTip) {
                    //需要动作执行提示信息
                    this.$alertDialog.find(".modal-dialog").width(380);
                    this.$alertContent.css("padding", "20px");
                    this.$alertHeader.html(tip_message.tip);
                    this.$alertContent.html(this.options.actionTip);
                    this.$alertFooter.hide();
                    this.$alertDialog.modal("show");
                }
            }
        } else this.cancel();
    },
    cancel:function() {
        this.$alertDialog.modal("hide");
        $(this.options.checkTable).find("thead th input[type='checkbox']").prop("checked", false);
        this.$checkboxs = $(this.options.checkTable).find("tbody td input[type='checkbox']:checked");
        if (Boolean(this.$checkboxs)) {
            this.$checkboxs.each(function() {
                $(this).prop("checked", false);
            });
        }
    }
};