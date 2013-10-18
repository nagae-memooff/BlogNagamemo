// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function clearDefaultContent(){
	var qknew = document.getElementById('quick_new');
	if (qknew.value == "来写个随笔吧" ) {
		qknew.value = "";
	}
}
function toDefaultContent(){
	var qknew = document.getElementById('quick_new');
	if (qknew.value == "" ) {
		qknew.value = "来写个随笔吧";
	}
}
function clearContent(){
	var qknew = document.getElementById('quick_new');
	qknew.value = "来写个随笔吧";
}

function repo(cmtcount,cmtuser){
	var repoarea = document.getElementById('comment_content');
	text = "回复 " + cmtuser + " 在 " + cmtcount + " 楼的评论：\n";
	repoarea.value = text;
	repoarea.focus();
}

function clearRepoArea(){
	var repo = document.getElementById("comment_content");
	repo.value = "";
}

