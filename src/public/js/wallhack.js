// Generated by CoffeeScript 1.9.0
(function() {
  var $, Wallhack, jsRoot, _;

  jsRoot = this;

  $ = jsRoot.$, _ = jsRoot._;

  Wallhack = {
    VERSION: '0.0.1',
    container: $('#wallhack'),
    tpls: {},
    components: {},
    init: function(callback) {
      $('.tpl').each(function() {
        var $el, name;
        $el = $(this);
        name = $el.attr('id').replace('tpl-', '');
        return Wallhack.tpls[name] = _.template($el.html());
      });
      return callback();
    },
    render: function(name) {
      var data;
      data = this.tpls[name];
      if (data == null) {
        throw new Error("Cannot find '" + name + "' template screen");
      }
      return this.container.html(data);
    },
    execute: function(query, callback) {
      return this.post('execute', {
        query: query
      }, callback);
    },
    list: function(callback) {
      return this.post('scripts/list', {}, callback);
    },
    create: function(data, callback) {
      return this.post('scripts/create', data, callback);
    },
    update: function(data, callback) {
      return this.post('scripts/update', data, callback);
    },
    "delete": function(data, callback) {
      return this.post('scripts/delete', data, callback);
    },
    post: function(action, data, callback) {
      return $.post("/" + action, {
        data: JSON.stringify(data)
      }, (function(_this) {
        return function(raw) {
          var res;
          res = _this.evalResponse(raw.data);
          if (!raw.success) {
            return callback(res);
          }
          return callback(null, res);
        };
      })(this));
    },
    evalResponse: function(response) {
      return (new Function("return " + response))();
    }
  };

  jsRoot.Wallhack = Wallhack;

}).call(this);
