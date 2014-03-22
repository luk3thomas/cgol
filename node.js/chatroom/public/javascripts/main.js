var socket = io.connect('http://localhost');

(function($){

    var send = function(e, data) {
        socket.emit(e, data);
    }

    var receive = function(data) {
        $('#chatroom').prepend([
            '<p>',
                '<span class="time">', (new Date).toString().replace(/([0-9]{2}:[0-9]{2}) .*/, '$1'), '</span>',
                '<span class="message">', data.message , '</span>',
            '</p>'
        ].join(''))
    }

    // Receive chats
    socket.on('connect', function(){
        socket.on('chats', receive);
    });

    // Send a chat
    $('#chat').submit(function(e){
        e.preventDefault();
        $textarea = $(this).find('#message');
        send('chat', $textarea.val());
        $textarea.val('');
    });

})(jQuery);
