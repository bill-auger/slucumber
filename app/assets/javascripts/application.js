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


//$(function()
$(document).ready(function() { registerAjaxSuccess() ; }) ;

$(document).ready(function()
{
console.log('registering ajax:complete callback') ;

  $('.edit_project').on('ajax:complete' , function(event , data , status , xhr)
  {
if (status == 'success') return ;
console.log('\najax:complete() status=' + status + ' event=' + event + ' data=' + data + ' xhr=' + xhr) ;
console.log("ajax:complete() " + ((!data.body)? "data=" + data :
    "html=Title: " + data.title + "<br />Body: " + data.body) + "\n") ;

//    $(this).replaceWith('<div>Title: ' + data.title + '</div>' +'<div>Body: ' + data.body + '</div>');
  }) ;
}) ;

/* Then, my JQuery to submit form on change:
  $(function() {
    $('.status_update').live('change', function() {
      $(this).parents('form:first').submit();
    });
  });
*/


function registerAjaxSuccess()
{
console.log('registering ajax:success callback') ;

//var projectForm = document.getElementsByClassName('edit_project')[0] ;
var projectFormDiv = document.getElementById('projectFormDiv') ;
//  $('form[data-update-target]').on('ajax:success' , function(event , data , status , xhr)
  $('.edit_project').on('ajax:success' , function(event , data , status , xhr)
  {
console.log('\najax:success() status=' + status + ' event=' + event + ' data=' + data.substring(0 , 30) + ' xhr=' + xhr + "\n") ;
console.log('ajax:success() target=' + $('#' + $(this).data('update-target'))) ;
//      $('#' + $(this).data('update-target')).html(data) ;
//      $('#' + $(this).data('update-target')).innerHTML = 'data' ;
//      projectForm.parentNode.parentNode.innerHTML = 'data' ; registerAjaxSuccess() ;
      projectFormDiv.innerHTML = data ; registerAjaxSuccess() ;
  }) ;
}

function toggleTagInput(thisInput)
{
  var thisDiv = thisInput.parentNode ; var parentTd = thisDiv.parentNode ;
  var tagTextDiv = parentTd.getElementsByClassName('eventTagTextDiv')[0] ;
  var tagBtnDiv = parentTd.getElementsByClassName('eventTagBtnDiv')[0] ;

//console.log("toggleTagInput() " + ((thisDiv == tagBtnDiv)? 'tagBtn=' + thisInput.innerHTML : ((thisDiv == tagTextDiv)? 'textBtn=' + thisInput.value : "err="))) ;

  if (thisDiv == tagBtnDiv)
  {
    tagBtnDiv.style.display = 'none' ;
    tagTextDiv.style.display = 'block' ;
    tagTextDiv.firstChild.focus() ;
  }
  else if (thisDiv == tagTextDiv)
  {
    var tagBtn = tagBtnDiv.children[0] ;
    tagBtn.innerHTML = thisInput.value ;
    tagTextDiv.style.display = 'none' ;
    tagBtnDiv.style.display = 'block' ;
  }
}

function submitNestedForm()
{
//put() ; return ;
  var projectForm = document.getElementsByClassName('edit_project')[0] ;
console.log("submitNestedForm() projectForm=" + projectForm) ;
//  var projectFormById = document.getElementById('edit_project_' + projectId) ;
//console.log("submitNestedForm() projectId=" + projectId + " projectForm=" + projectForm + " projectFormById=" + projectFormById) ;
  //console.log("submitNestedForm() projectForm(class)=" + projectForm) ;
//console.log("submitNestedForm() projectForm(   id)=" + projectFormById) ;
//console.log("submitNestedForm() (projectForm(class) == projectForm(id))?=" + (projectForm == projectFormById)) ;

//  projectFormById.submit() ;
    clickSubmitBtn() ;
/*
    $.ajax({
      type: "POST",
      url: "bin/process.php",
      data: dataString,
      success: function() {
        $('#contact_form').html("<div id='message'></div>");
        $('#message').html("<h2>Contact Form Submitted!</h2>")
        .append("<p>We will be in touch soon.</p>")
        .hide()
        .fadeIn(1500, function() {
          $('#message').append("<img id='checkmark' src='images/check.png' />");
        });
      }
    });
*/
}

function clickSubmitBtn()
  { document.getElementById('projectEditBtnsDiv').children[1].click() ; }

/*
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

function ajaxPutProject(params)
{
  $.ajax({ type: 'PUT' , url: '/projects/34' , data: params , success: function (data)
  {
console.log('ajaxPost callback data=" + data + " title=' + data.title + ' body=' + data.body) ;
  } }) ;
}
function put() { ajaxPutProject('{}') ; }
//<%= '<script type="text/javascript">window.setTimeout(submitNestedForm , 5000) ;</script>' if event.new_record? %>
*/

//$(window).unload(function() { $('select option').remove() ; }) ;

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