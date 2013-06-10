// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree .


//$(window).unload(function() { $('select option').remove() ; }) ;

function submitNestedForm(projectId)
{
//put() ; return ;
  var projectForm = document.getElementsByClassName('edit_project')[0] ;
  var projectFormId = document.getElementById('edit_project_' + projectId) ;
console.log("submitNestedForm() projectId=" + projectId + " projectForm=" + projectForm + " projectFormId=" + projectFormId) ;
console.log("submitNestedForm() projectForm(class)=" + projectForm) ;
console.log("submitNestedForm() projectForm(   id)=" + projectFormId) ;
console.log("submitNestedForm() (projectForm(class) == projectForm(id))?=" + (projectForm == projectFormId)) ;
/*
  projectFormId.on('ajax:complete' , function(event , data , status , xhr)
  {
console.log("submitNestedForm() callback status=" + status) ;
console.log('submitNestedForm() callback html=<div>Title: ' + data.title + '</div>' +'<div>Body: ' + data.body + '</div>');

    $(this).replaceWith('<div>Title: ' + data.title + '</div>' +'<div>Body: ' + data.body + '</div>');
  }) ;
*/
/* Then, my JQuery to submit form on change:
  $(function() {
    $('.status_update').live('change', function() {
      $(this).parents('form:first').submit();
    });
  });
*/
  projectFormId.submit ;
}

function clickSubmitBtn()
{
  var submitBtn = document.getElementById('projectEditBtnsDiv').children[1] ;
  submitBtn.on('ajax:complete' , function(event , data , status , xhr)
  {
console.log("clickSubmitBtn() callback status=" + status) ;
console.log('clickSubmitBtn() callback html=<div>Title: ' + data.title + '</div>' +'<div>Body: ' + data.body + '</div>');
  }) ;
  submitBtn.click ;
}

function ajaxPost(actorId , actorJson , anInput)
{
  var actorUrl = "actors/" + actorId + "/edit" ;
console.log("ajaxPost() actorUrl=" + actorUrl + " anInput=" + anInput) ;

  $.ajax({ type: 'PUT' , url: actorUrl , data: actorJson , success: function (data)
  {
console.log('ajaxPost callback data=" + data + " title=' + data.title + ' body=' + data.body) ;

//    if (anInput.type == 'text') anInput.value = 'data' ;
  } }) ;
}

function put()
{
  $.ajax({ type: 'PUT' , url: '/projects/34' , data: '{}', success: function (data)
  {
console.log('ajaxPost callback data=" + data + " title=' + data.title + ' body=' + data.body) ;
  } }) ;
}

//<%= '<script type="text/javascript">window.setTimeout(submitNestedForm , 5000) ;</script>' if event.new_record? %>

/*
 
  var projectForm = document.getElementsByClassName('edit_project')[0] ; // Id('edit_project_18') ;
  $.ajax(
    {
      type: 'PUT' ,
      url: 'projects' ,
      data: project_json ,
      success: function(data) { console.log('callback via ajaxPost eval=' + data) ; eval(data) ; }
    }) ;
//  projectForm.submit() ;
*/
  /*
$('form.new_article').on('ajax:success' , function(event , data , status , xhr)
{
    $(this).replaceWith('<div>Title: ' + data.title + '</div>' +'<div>Body: ' + data.body + '</div>');
});
*/


/*
  $.ajax({ type: 'POST' , url: 'actors' , data: 'actor={kind:akind}' ,
         success: function(data) { console.log('callback data=' + data) ; eval(data) ; } }) ;
*/
/*
<% update_url = "actors/" + @actor.id.to_s %>
<% p "_actor_fields.html.erb update_url=" + update_url %>
    <% ajx = "$.ajax({ type: 'PUT' , url: '" + update_url + "' data: 'param1=value1&params2=value2', success: function(data) { console.log('callback data=' + data) ; eval(data) ; } }) ;" %>
    <% ajx = "$.ajax({url: '" + update_url + "' ," + "data: 'selected='" + this.value + ", dataType: 'script'}) ;" %>  
*/
/*
<%= javascript_include_tag :defaults %>
And in your public/javascripts directory, you should find :
application.js, controls.js, dragdrop.js, effects.js, prototype.js, rails.js
*/

/*
function clobberPartial(cnt , partial , formId , project)
{
console.log("clobberPartial formId=" + formId + " controller=" + cnt + " partial=" + partial) ;

  var html = "<%=j render :partial => cnt + '/' + formId %>" ;
}
*/


//function(event , data , status , xhr)
function renderEventsForm(projectId , html)
{
console.log("renderEventsForm() callback html=\n");// + html) ;

  var projectFormId = 'edit_project_' + ((projectId > 0)? projectId : "" )
  var projectForm = document.getElementById(projectFormId) ;
console.log("renderEventsForm() callback projectId=" + projectId + " projectForm=" + projectForm) ;

  projectForm.replaceWith(html) ;
//  projectForm.html(html) ;
}