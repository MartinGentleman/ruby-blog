var dynamic_menu_changes_to_save = false;
function showSaveActionForDynamicMenu(){
	if(!dynamic_menu_changes_to_save) {
		dynamic_menu_changes_to_save = true;
		$("#dynamic-menu-web-pages").append('<button onclick="saveDynamicMenu(this);">'+Translator.i18n("Save")+'</button>');
	}
}
$(function() {
	$("#sortable-dynamic-menu-items").sortable({
		change: function( event, ui ) {
			showSaveActionForDynamicMenu();
		}
	});
	$("#sortable-dynamic-menu-items").disableSelection();
	$("#sortable-dynamic-menu-items>li").each(function(){
		$("#dynamic-menu-table-page-"+$(this).attr("id").substring(27)).css("color","gray");
	});
});
function pickWebPageForDynamicMenu(id, title, origin) {
	if($("#sortable-dynamic-menu-item-"+id).length){
		$("#sortable-dynamic-menu-item-"+id).remove();
		$(origin).css("color","#fff");
	} else {
		$("#sortable-dynamic-menu-items").append('<li id="sortable-dynamic-menu-item-'+id+'">'+title+'</li>');
		$(origin).css("color","gray");
	}
	showSaveActionForDynamicMenu();
}
function saveDynamicMenu(origin){
	var dynamic_menu = [];
	$("#sortable-dynamic-menu-items>li").each(function(){
		dynamic_menu.push($(this).attr("id").substring(27));
	});
	var json_data = {'menu_name':dynamic_menu_name_to_replace,'dynamic_menu':dynamic_menu};
	$.ajax({
        url: '/dynamic_menus/replace_by_menu_title',
        type: 'POST',
        dataType: 'json',
        data: json_data,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
        success: function (msg) {
        	// we remove the saving button
            $(origin).remove();
			dynamic_menu_changes_to_save = false;
			Alert.confirmation(Translator.i18n("Menu_saved"));
        },
        error: function (xhr, status) {
        	Alert.error(Translator.i18n("Menu_save_error"));
        }
    });
}