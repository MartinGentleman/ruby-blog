var syntax_highlighter_cdn = [];
syntax_highlighter_cdn['core'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shCore.min.js';
syntax_highlighter_cdn['ruby'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushRuby.min.js';
syntax_highlighter_cdn['csharp'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushCSharp.min.js';
syntax_highlighter_cdn['groovy'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushGroovy.min.js';
syntax_highlighter_cdn['sql'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushSql.min.js';
syntax_highlighter_cdn['jscript'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushJScript.min.js';
syntax_highlighter_cdn['java'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushJava.min.js';
syntax_highlighter_cdn['php'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushPhp.min.js';
syntax_highlighter_cdn['xml'] = 'https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushXml.min.js';

var syntax_highlighter_queue = [];

$(function(){
	$("pre").each(function(index) {
		css_class = $(this).attr("class");
		if(css_class.substring(0, 7) == "brush: ") {
			language = css_class.substring(7);
			if($.inArray(syntax_highlighter_cdn[language], syntax_highlighter_queue) == -1) {
				syntax_highlighter_queue[syntax_highlighter_queue.length] = syntax_highlighter_cdn[language];
			}
		}
	});
	if(syntax_highlighter_queue.length > 0) {
		$.getScript(syntax_highlighter_cdn['core'], function(){
			counter = 0;
			for (i = 0; i < syntax_highlighter_queue.length; ++i) {
			    $.getScript(syntax_highlighter_queue[i], function(){
			    	counter = counter+1;
			    	if(syntax_highlighter_queue.length == counter){
			    		SyntaxHighlighter.highlight();
			    	}
			    });
			}
		});
	}
});