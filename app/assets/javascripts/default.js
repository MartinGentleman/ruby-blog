
// check if object exists in DOM
jQuery.fn.exists = function() {
	return this.length>0;
};

jQuery.fn.center = function(position) {
	if(position && position == "absolute") {
		this.css("position", "absolute");
		this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	} else if(!position || position == "fixed") {
		this.css("position", "fixed");
		this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2)) + "px");
	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2)) + "px");
	}
	
};

// check if a variable stores a function
function isFunction(functionToCheck) {
 var getType = {};
 return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
}

/*
 * alerting
 */
var Alert = new function Alert() {
	this.counter = 0;
	this.confirmation = function(message) {
		this.counter = this.counter +1;
		this.raw(message, "alert-confirmation", "alert-"+this.counter);
	};
	this.error = function(message) {
		this.counter = this.counter +1;
		this.raw(message, "alert-error", "alert-"+this.counter);
	};
	this.raw = function(message, css, id) {
		console.log("Alert: "+message);
		if(!$("#alerts").exists()) $("h1").first().after('<div id="alerts"><ul></ul></div>');
		$("#alerts>ul").append('<li class="'+css+'" id="'+id+'">'+message+'</li>');
		setTimeout(function(){window.Alert.destroy(id);}, 5000);
	};
	this.destroy = function(id) {
		$("#"+id).fadeOut("slow", function(){$("#"+id).remove();});
	};
};

/*
 * translates based on translations_locale.js files
 */
var Translator = new function() {
	this.i18n = function(symbol){
		//console.log('Translate '+symbol+' to '+translations[symbol]+', locale:'+this.locale);
		if(translations[symbol]) {
			return translations[symbol];
		} else {
			return symbol;
		}
	};
	this.locale = locale;
};

/*
 * a see-through page cover
 */
var PageCover = new function() {
	this.isVisible = false;
	this.onDestroyCallback = function(){};
	this.create = function(onDestroyCallback) {
		if (isFunction(onDestroyCallback)) this.onDestroyCallback = onDestroyCallback;
		if(!this.isVisible){
			this.isVisible = true;
			$("body").append($('<div id="page-cover">&nbsp;</div>').click(function(){
				PageCover.destroy();
			}));
		}
	};
	this.destroy = function() {
		if(!PageCover.isVisible) return; 
		this.isVisible = false;
		this.onDestroyCallback();
		$("#page-cover").remove();
	};
};

/*
 * dialogue window with a see-through page cover
 */
function DialogueWindow (options) {
	this.isVisible = false;
	this.html = options && options.html ? options.html : '';
	this.width = options && options.width ? options.width : 'auto';
	this.height = options && options.height ? options.height : 'auto';
	this.setHtml = function(html) {
		this.html = html || this.html;
		if(this.isVisible) $("#dialogue-window").html(this.html);
	};
	this.setDimensions = function(options) {
		this.width = options && options.width ? options.width : this.width;
		this.height = options && options.height ? options.height : this.height;
		if(this.isVisible) {
			$("#dialogue-window").width(this.width).height(this.height).center();
			if(this.width == "auto" && $("#dialogue-window").width() < 400) {
				this.setDimensions({width:"400px"});
			}
		}
	};
	this.create = function(onDestroyCallback) {
		PageCover.create(this.destroy);
		$("body").append('<div id="dialogue-window"></div>');
		this.isVisible = true;
		this.setHtml();
		this.setDimensions();
	};
	this.destroy = function() {
		this.isVisible = false;
		PageCover.destroy();
		$("#dialogue-window").remove();
	};
}

var ConfirmationDialogue = new function ConfirmationDialogue() {
	this.origin;
	this.html;
	this.dialogue;
	this.create = function(origin, message) {
		this.origin = origin;
		this.html = html = '<p>'+(message || Translator.i18n("Are_you_sure"))+'</p><hr class="cleaner" />'+
		'<button onclick="ConfirmationDialogue.destroy(true);">'+Translator.i18n("true")+'</button><button onclick="ConfirmationDialogue.destroy(false);">'+Translator.i18n("false")+'</button>';
		if(this.dialogue && this.dialogue.isVisible && PageCover.isVisible) return true;
		this.dialogue = new DialogueWindow({html: this.html});
		this.dialogue.create();
		return false;
	};
	this.destroy = function(confirmation) {
		if(confirmation && this.origin) {
			if($(this.origin).is("button") || ($(this.origin).is("input") && $(this.origin).attr("type") == "submit")){
				$(this.origin).click();
			}
		}
		this.dialogue.destroy();
	};
};
