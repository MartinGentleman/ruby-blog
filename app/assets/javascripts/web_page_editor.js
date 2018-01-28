// this is froala wysiwyg editor
//= require froala_editor.min.js
//= require plugins/media_manager.min.js
//= require plugins/tables.min.js
//= require plugins/video.min.js
//= require plugins/lists.min.js
//= require plugins/fullscreen.min.js
//= require langs/cs.js

var areWeEditing = false;
var editPageImages = null;
var targetEditPageImage = null;

function editPageSchedule(scheduleHtml){
	scheduleDialogueWindow = new DialogueWindow({html: scheduleHtml});
	scheduleDialogueWindow.create();
	$('.datetimepicker').datetimepicker({theme:'dark'});
}

function editPageSaveDraft(){
	$("#page-contents").editable("save");
	location.reload();
}

function editPageImagePicked(image, id) {
	targetEditPageImage = id;
	$("body").css("background-image",'url('+image.src.replace("thumb","original")+')');
	$("#page-background-image img").css("opacity", 1);
	$(image).css("opacity", 0.5);
}

function saveEditPageImage() {
	if(targetEditPageImage == null) return;
	//imageId = targetEditPageImage.substring(targetEditPageImage.indexOf("images/")+7,targetEditPageImage.indexOf("/original"));
	$.ajax({
        url: '/web_pages/edit_page_image/'+updateID,
        type: 'POST',
        data: {image_id:targetEditPageImage},
        dataType: 'json',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
        success: function (msg) {
            Alert.confirmation(Translator.i18n("Image_saved"));
        },
        error: function (xhr, status) {
        	Alert.error(Translator.i18n("Image_save_error"));
        }
    });
}

function loadEditPageImages() {
	if(editPageImages == null) {
		$.ajax({
	        url: '/media_manager/2.json',
	        type: 'GET',
	        dataType: 'json',
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
	        success: function (msg) {
	        	editPageImages = msg;
	        	for (i = 0; i < editPageImages.length; i++) {
				    $("#page-background-image").append('<img onclick="editPageImagePicked(this,'+editPageImages[i]["id"]+');" src="'+editPageImages[i]["link"].replace("original","thumb")+'" width="100" />');
				}
				$("#page-background-image").append('<hr class="cleaner" /><a href="media_manager">Media Manager</a>');
	        },
	        error: function (xhr, status) {
	        	Alert.error(Translator.i18n("Images_load_error"));
	        }
	    });
   }
}

function startFroala() {
	$('#page-contents').editable({
      inlineMode: false,
      toolbarFixed: false,
      defaultImageWidth: false,
      spellcheck: true,
      language: Translator.locale,
      buttons: ["bold", "italic", "underline", "strikeThrough", "subscript", "superscript", "insertCode", "fontFamily", "fontSize", "color", "formatBlock", "blockStyle", "inlineStyle", "insertOrderedList", "insertUnorderedList", "outdent", "indent", "selectAll", "createLink", "insertImage", "insertVideo", "table", "undo", "redo", "html", "save", "removeFormat", "fullscreen"],
      customButtons: {
            insertCode: {
                title: Translator.i18n("Insert_code"),
                icon: {
                    type: 'font',
                    value: 'fa fa-dollar' // Font Awesome icon class fa fa-*
                },
                callback: function (editor) {
                    this.saveSelection();

                    var codeModal = $("<div>").addClass("froala-modal").appendTo("body");
                    var wrapper = $("<div>").addClass("f-modal-wrapper").appendTo(codeModal);
                    $("<h4>").append('<span data-text="true">'+Translator.i18n("Insert_code")+'</span>')
                        .append($('<i class="fa fa-times" title="Cancel">')
                        .click(function () {
                            codeModal.remove();
                        }))
                        .appendTo(wrapper);

                    var dialog = "<textarea id='code_area' style='height: 211px; width: 538px;' /><br/><label>"+Translator.i18n("Language")+":</label><select id='code_lang'><option>Ruby</option><option>CSharp</option><option>Php</option><option>JScript</option><option>Sql</option><option>XML</option><option>Java</option><option>Groovy</option></select> <input type='button' name='insert' id='insert_btn' value='Insert' /><br/>";
                    $(dialog).appendTo(wrapper);

                    $("#code_area").text(this.text());

                    if (!this.selectionInEditor()) {
                        this.$element.focus();
                    }

                    $('#insert_btn').click(function () {
                        var lang = $("#code_lang").val();
                        var code = $("#code_area").val();
                        code = code.replace(/\s+$/, ""); // rtrim
                        code = $('<span/>').text(code).html(); // encode        

                        var htmlCode = "<pre class='brush: " + lang.toLowerCase() + "'>" + code + "</pre></div>";
                        var codeBlock = "<div align='left' dir='ltr'>" + htmlCode + "</div><br/>";
                        $("#page-contents").editable("restoreSelection");
                        $("#page-contents").editable("insertHTML", codeBlock);
                        $("#page-contents").editable("saveUndoStep");

                        codeModal.remove();
                    });
                }
            }
      },
      saveURL: '/web_pages/update_content',
      saveParams: {
		authenticity_token: $('meta[name="csrf-token"]').attr('content'),
		title: $("h1").text(),
		id: updateID
	  },
	  saveErrorCallback: function (error) {
	  	Alert.error(Translator.i18n("Web_page_save_error"));
	  },
	  imageUploadURL: '/images',
      imageUploadParams: {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
      },
      imagesLoadURL: '/images/all_image_links/1',
      imageErrorCallback: function (error) {
        Alert.error(Translator.i18n("Image_save_error"));
      }
    });
    $("a[href='http://editor.froala.com']").remove();
}

function toggleEditWebPage() {
	if(areWeEditing ===  false) {
		$("#edit-page-button").css("display","none");
		$("#edit-page-tabs").css("display","block");
		$("#edit-page-save-as-draft").css("display","inline");
		$("#page-admin-tabs").tabs({
			active: 0,
			activate: function( event, ui ) {
				if(ui.newPanel.attr("id") == "page-background-image") {
					loadEditPageImages();
				}
			}
		});
		$("#page-contents").html(originalHTMLContent);
	    startFroala();
	    $('.contents').append('<div class="textEditingButtons">' +
	    '<button onclick="toggleEditWebPage();">'+Translator.i18n("Cancel")+'</button>' +
	    '<button onclick="$(\'.contents\').editable(\'save\')">'+Translator.i18n("Save")+'</button></div>');
	    areWeEditing = true;
	} else {
		$('.textEditingButtons').remove();
		$("#page-contents").editable("destroy");
		$("#page-admin-tabs").tabs("destroy");
		$("#page-details").css("display","none");
		$("#page-background-image").css("display","none");
		$("#edit-page-tabs").css("display","none");
		$("#edit-page-save-as-draft").css("display","none");
		$("#edit-page-button").css("display","block");
		$("#page-contents").html(originalHTMLContent);
		if (typeof SyntaxHighlighter != "undefined") SyntaxHighlighter.highlight();
		areWeEditing = false;
	}
}