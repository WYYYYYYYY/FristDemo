(function($) {
    
    var SWtable = function SWtable(element, options) {
	this.init(element, options);
    };
    
    SWtable.prototype = {
	init : function (element, options) {
	    var self = this;
	    var $element = $(element);
	    this.$element = $element;
	    
	    var $tbody = $element.find('tbody');
	    self.ths = [];
	    $element.find('th').each(function(index, item) {
		var $this = $(item);
		var swfunc = $this.data('swfunc');
		if (typeof(swfunc) !== "undefined") {
		    self.ths.push(swfunc);
		} else {
		    var swname = $this.data('swname');
		    self.ths.push(swname);
		}
	    });
	    $element.find('th input[type="checkbox"]').change(
		function() {
		    $element.find('td input[type="checkbox"]').each(function() {
			this.checked = $element.find('th input[type="checkbox"]').is(":checked");
		    });
		}
	    );
	    this.setOptions(options);
	},
	setOptions : function (options) {
	    this.options = $.extend({}, $.fn.swtable.default_options, options);
	    this.submit(this.options.url);
	},
	refresh : function () {
	    this.submit(this.url, this.postdata);
	},
	submit : function(url, data) {
	    var self = this;
	    var $element = this.$element;
	    this.url = url;
	    this.postdata = data;
	    $element.find('tbody').empty();
	    $element.find('th input[type="checkbox"]').prop('checked', false);
	    $.post(url, data)
	    .done(function (data) {
	        self.data = data;
	        var options = self.options;
	        var content = data[options.content];
	        
	        if (data[options.result] == "failed") {
	            if (typeof(options.failCallback) === "function") {
	        	options.failCallback(data);
	            }
	            return;
	        }
	        
	        var html = '';
	        if (options.template == "") {
        	    $.each(content, function(index, item) {
        	        html += '<tr>';
        	        $.each(self.ths, function(i, th) {
        	    	html += '<td>';
        	    	if (typeof(options[th]) !== "undefined") {
        	    	    html += options[th](index, data);
        	    	} else {
        	    	    html += item[th];
        	    	}
        	    	html += '</td>';
        	        });
        	        html += '</tr>';
        	    });
	    	} else {
	    	    $.each(content, function(index, item) {
	    		html += options.template(index, data);
	    	    });
	    	}
	        $element.find('tbody').html(html);
	        
	        $element.find('td input[type="checkbox"]').change(
	            function onTdCheckboxChange() {
	        	if (this.checked &&
	        		$element.find('td input[type="checkbox"]').length == $element.find('td input[type="checkbox"]:checked').length) {
	        	    $element.find('th input[type="checkbox"]').prop('checked', true);
	        	} else {
	        	    $element.find('th input[type="checkbox"]').prop('checked', false);
	        	}
	            }
	        );
	        
	        $element.find('[data-swoperator]').click(
	            function () {
	        	var $this = $(this);
	        	var swoperator = $this.data('swoperator');
	        	if (typeof(options[swoperator]) === "function") {
	        	    options[swoperator]($this);
	        	}
	            }
	        );
	        
	        if (typeof(options.successCallback) === "function") {
	            options.successCallback(data);
	        }
	    })
	    .fail(this.fail);
        },
        fail : function() {
            console.log("swtable submit fail.");
        },
        tdCheckedboxs : function() {
            var $element = this.$element;
            var checked = [];
            $element.find('td input[type="checkbox"]:checked').each(function(index) {
        	checked.push(index);
            });
            return checked;
        },
        tdCheckedboxValues : function() {
            var $element = this.$element;
            var checkedValues = [];
            $element.find('td input[type="checkbox"]:checked').each(function(index) {
        	checkedValues.push(this.value);
            });
            return checkedValues;
        }
    };
    
    old = $.fn.swtable;
    
    $.fn.swtable = function(options) {
	
	if (!Boolean(options)) {
	    return this.data('swtable');
	}
	
	return this.each(function(index, item) {
	   var $this = $(item); 
	   data = $this.data('swtable');
           options = (typeof options !== 'object') ? null : options;
	   
	   if (!data) {
               $this.data('swtable', (data = new SWtable(this, options)));
               return;
           }

           if (typeof option === "object") {
               result = data.setOptions(option);
           }
	});
    };
    
    $.fn.swtable.default_options = {
	"url" : "",
	"data" : "",
	"result" : "result",
	"content" : "",
	"template" : "",
	"successCallback" : "",
	"failCallback" : ""
    };
        
})(jQuery);