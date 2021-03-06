// Generated by CoffeeScript 1.9.0
(function() {
  var Editor, Logger, Wallhack, jsRoot, tpls, _ref;

  jsRoot = this;

  Wallhack = jsRoot.Wallhack;

  _ref = Wallhack.components, Editor = _ref.Editor, Logger = _ref.Logger;

  tpls = Wallhack.tpls;

  Wallhack.init(function() {
    var ed;
    Wallhack.render('index');
    ed = new Editor({
      el: '#editor',
      editor: 'sqlEditor',
      logger: new Logger({
        el: '#sqlResponse',
        template: tpls.reponse
      })
    });
    return ed.setQuery("SELECT TOP 10 * FROM tblMenu ORDER BY UtcLastModifiedOn DESC");
  });

}).call(this);
