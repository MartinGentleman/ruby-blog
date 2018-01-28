/*
 * solution from http://reed.github.io/turbolinks-compatibility/facebook.html
 * Facebook plugins don't work with turbolinks so we make them
 */

fb_root = null;
fb_events_bound = false;

$(function () {
  loadFacebookSDK();
  if(!fb_events_bound) bindFacebookEvents();
});

function bindFacebookEvents() {
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', function() {
      FB.XFBML.parse();
    });
  fb_events_bound = true;
}

function saveFacebookRoot() {
  fb_root = $('#fb-root').detach();
 }

function restoreFacebookRoot() {
  if ($('#fb-root').length > 0)
    $('#fb-root').replaceWith(fb_root);
  else
    $('body').append(fb_root);
}

function loadFacebookSDK() {
  window.fbAsyncInit = initializeFacebookSDK;
  $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
 }

function initializeFacebookSDK() {
  FB.init({ status: true, cookie: true, xfbml: true });
}