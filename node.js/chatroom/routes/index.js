
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Express' });
};

/*
 * GET chat page.
 */

exports.chat = function(req, res){
  res.render('chat', { title: 'Chatty Chatterson' });
};
