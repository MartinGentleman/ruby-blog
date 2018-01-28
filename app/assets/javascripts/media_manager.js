// this is fileupload jquery plugin
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

var media_manager_picked_id = 0;

function pickImage(image,id) {
	$("#media_manager_info_image").attr("src", image.src.replace("thumb","medium"));
	media_manager_picked_id = id;
	$("#media_manager_index_table img").css("opacity", 1);
	$(image).css("opacity", 0.5);
	$("#media_manager_info_area").css("visibility","visible");
}
function deleteImage() {
	$.ajax({
        url: '/images/'+media_manager_picked_id,
        type: 'DELETE',
        dataType: 'json',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function (msg) {
            $("#media_manager_info_area").css("visibility","hidden");
            location.reload();
        },
        error: function (xhr, status) {
        	console.log('ERROR: %O', xhr.error);
        }
    });
}
$(function () {
	$('#fileupload').fileupload({
        dataType: 'json',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        done: function (e, data) {
            location.reload();
        }
    });
});