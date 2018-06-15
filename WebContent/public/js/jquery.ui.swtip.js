(function($) {
    
    var SWtip = function SWtip(element, options) {
	this.init(element, options);
    };
    
    SWtip.prototype = {
	init : function (element, options) {
	    var self = this;
	    var $element = $(element);
	    this.$element = $element;
	    this.setOptions(options);
	},
	setOptions : function (options) {
	    this.options = $.extend({}, $.fn.swtip.default_options, options);
	    this.submit();
	},
	submit : function() {
	    var self = this;
	    var $element = this.$element;
	    $.post(self.options.url, self.options.data)
	    .done(function (data) {
		var result = false;
		var options = self.options;
	        if (typeof(options.predicate) === "function") {
	            result = options.predicate(data);
	        } else {
	            if (data[options.result] == "success") {
	        	result = true;
	            } 
	        }
	        if (result) {
	            $(options.successSelector).slideDown();
	       	    setTimeout(function () {
			$(options.successSelector).slideUp();
		    }, 3000);
	       	    if (typeof(options.successCallback) === "function") {
	       		options.successCallback(data);
	       	    }
	        } else {
	            $(options.failSelector).slideDown();
	       	    setTimeout(function () {
			$(options.failSelector).slideUp();
		    }, 3000);
	       	    if (typeof(options.failCallback) === "function") {
	       		options.failCallback(data);
	       	    }
	        }
	    })
	    .fail(this.fail);
        },
        fail : function() {
            console.log("swtip submit fail.");
        }
    };
    
    old = $.fn.swtip;
    
    $.fn.swtip = function(options) {
	
	if (!Boolean(options)) {
	    return this.data('swtip');
	}
	
	return this.each(function(index, item) {
	   var $this = $(item); 
	   data = $this.data('swtip');
           options = (typeof options !== 'object') ? null : options;
	   
	   if (!data) {
               $this.data('swtip', (data = new SWtip(this, options)));
               return;
           } else {
               data.setOptions(options);
           }

           if (typeof option === "object") {
               result = data.setOptions(option);
           }
	});
    };
    
    $.fn.swtip.default_options = {
	"url" : "",
	"data" : "",
	"result" : "result",
	"predicate" : "",
	"successSelector" : "",
	"failSelector" : "",
	"successCallback" : "",
	"failCallback" : ""
    };
        
})(jQuery);