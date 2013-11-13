$(document).ready(function() {

  $('a.unfollow_link').click(function(event) {
    event.preventDefault();
    var parentDiv = $(this).closest('.comic');
    var lastIssue = $(this).closest('.small-bold');
    var url = $(this).attr('href');
    $(parentDiv).removeClass('followed');
    $(lastIssue).toggle();
    $.get(url);
  });

});