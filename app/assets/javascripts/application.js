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
//= require tinymce
//= require_tree .

function clearContent(){
  var qknew = document.getElementById('quickbox');
  qknew.value = "";
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

//function searchByKeywords(evt){
//  var evt = evt ? evt : (window.event ? window.event :null);//兼容IE和FF
//  if (evt.keyCode==13){
//    var keywords = document.getElementById('search_keywords').value;
//    window.location.href='/search?search_keywords=' + keywords;
//  }
//}

function searchByKeywords(){
  var keywords = document.getElementById('search_keywords').value;
  window.location.href='/search?search_keywords=' + keywords;
}

function quickNewPostDivSlideUp() {
  $("#quick-new").animate({top: '-80px'}, {queue: false, duration: "fast"});
}

function quickNewPostDivSlideDown() {
  $("#quick-new").animate({top: '40px'}, {queue: false, duration: "fast"});
}
function ctrlEnter(event, id) {
  if(event.ctrlKey && event.keyCode==13) {
    document.getElementById(id).click();
    return false;
  }
}

function toggleLog() {
  $("#log").slideToggle();
}
function searchByPressEnter(event) {
  if( event.keyCode==13) {
    this.click();
    return false;
  }
}
