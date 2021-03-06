// Generated by CoffeeScript 1.9.0
(function() {
  var Backbone, Editor, Wallhack, ace, jsRoot, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  jsRoot = this;

  _ = jsRoot._, ace = jsRoot.ace, Backbone = jsRoot.Backbone, Wallhack = jsRoot.Wallhack;

  Editor = (function(_super) {
    __extends(Editor, _super);

    function Editor(options) {
      this.onExecDone = __bind(this.onExecDone, this);
      _.extend(this, options);
      if (!this.logger) {
        throw new Error("the 'logger' is missing");
      }
      this.editor = ace.edit(this.editor);
      this.editor.getSession().setMode("ace/mode/sql");
      options.events = {
        'click button.execute': 'execute'
      };
      Editor.__super__.constructor.apply(this, arguments);
    }

    Editor.prototype.execute = function() {
      return Wallhack.execute(this.getQuery(), this.onExecDone);
    };

    Editor.prototype.setQuery = function(sql) {
      return this.editor.getSession().setValue(sql);
    };

    Editor.prototype.getQuery = function(sql) {
      return this.editor.getSession().getValue(sql);
    };

    Editor.prototype.onExecDone = function(error, lines) {
      this.logger.setData(error, lines);
      return this.logger.render();
    };

    return Editor;

  })(Backbone.View);

  Wallhack.components.Editor = Editor;

}).call(this);
