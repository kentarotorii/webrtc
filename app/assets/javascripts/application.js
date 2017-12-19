// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(window).on('turbolinks:load', function() {
  $('#mybutton').on('click', function(){
       console.log('hello world! from jQuery');
  });
  'use strict';

  let localStream = null;
  let theirStream = null;
  let peer = null;
  let existingCall = null;

  navigator.mediaDevices.getUserMedia({video: true, audio: true})
      .then(function (stream) {
          // Success
          $('#my-video').get(0).srcObject = stream;
          localStream = stream;
      }).catch(function (error) {
      // Error
      console.error('mediaDevice.getUserMedia() error:', error);
      return;
  });

  peer = new Peer({
      key: '439f50de-da89-4848-b13b-41ca198ba8d9',
      debug: 3
  });

  peer.on('open', function(){
      $('#my-id').text(peer.id);
  });

  peer.on('error', function(err){
      alert(err.message);
  });

  peer.on('close', function(){
  });

  peer.on('disconnected', function(){
  });

  $('#make-call').submit(function(e){
      e.preventDefault();
      const call = peer.call($('#callto-id').val(), localStream);
      setupCallEventHandlers(call);
  });

  $('#end-call').click(function(){
      existingCall.close();
  });

  peer.on('call', function(call){
      call.answer(localStream);
      setupCallEventHandlers(call);
  });

  function setupCallEventHandlers(call){
      if (existingCall) {
          existingCall.close();
      };

      existingCall = call;

      call.on('stream', function(stream){
          addVideo(call,stream);
          setupEndCallUI();
          $('#their-id').text(call.remoteId);
          theirStream = stream; /*tmp*/
      });
      call.on('close', function(){
          removeVideo(call.remoteId);
          setupMakeCallUI();
      });
  }

  function addVideo(call,stream){
      $('#their-video').get(0).srcObject = stream;
  }

  function removeVideo(peerId){
      $('#'+peerId).remove();
  }

  function setupMakeCallUI(){
      $('#make-call').show();
      $('#end-call').hide();
  }

  function setupEndCallUI() {
      $('#make-call').hide();
      $('#end-call').show();
  }
  /*------------------------------------*/
  let localVideo =  document.getElementById('local_video');
  let playbackVideo =  document.getElementById('playback_video');
  let anchor = document.getElementById('downloadlink');
  let recorder =  null;
  let blobUrl = null;

  $('#start_record_button').click(function(){
    if (! localStream) {
      console.warn("no stream");
      return;
    }
    if (recorder) {
      console.warn("recorder already exist");
      return;
    }

    recorder = new MediaRecorder(localStream);
    console.log(localStream);
    recorder.ondataavailable = function(evt) {
      console.log("data available, start playback");
      var videoBlob = new Blob([evt.data], { type: evt.data.type });
      blobUrl = window.URL.createObjectURL(videoBlob);
      playbackVideo.src = blobUrl;
      playbackVideo.onended = function() {
      playbackVideo.pause();
      playbackVideo.src = "";
    };

    anchor.download = 'recorded.webm';
    anchor.href = blobUrl;

    playbackVideo.play();
    }

    recorder.start();
      console.log("start recording");
    });

  $('#stop_record_button').click(function(){
  if (recorder) {
    recorder.stop();
    console.log("stop recording");
  }
  });

  $('#play_button').click(function(){
    if (blobUrl) {
    playbackVideo.src = blobUrl;
    playbackVideo.onended = function() {
      playbackVideo.pause();
      playbackVideo.src = "";
    };

    playbackVideo.play();
    }
  });
  /*------------------------------------*/

});
