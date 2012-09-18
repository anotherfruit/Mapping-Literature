function mxnDrawHideButtons() {
  $("#toolbar").css('display', 'none');
}

function mxnDrawInit(map) {
  if(this.data('collection')) {
    mxnDrawHideButtons();
  }

  $('ul#features').on('click', '.remove', function() {
    $("#toolbar").css('display', 'block').find(".btn").removeClass("active");
  })
}
