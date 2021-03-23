(function() {
  addListenerMulti(window, '.toggle-window', function(e) {
    e.preventDefault();
    let panel = $(this).parent().parent();
    let messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.panel-body').is(':visible')) {
      let height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();

function addListenerMulti(el, s, fn) {
  s.split(' ').forEach(e => el.addEventListener(e, fn, false));
}