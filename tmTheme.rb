# encoding: utf-8
require 'plist'

class TmTheme

  def initialize(name, author, settings)
    @name = name
    @author = author
    @settings = settings
    @fields = []
  end

  def []=(key, value)
    @fields << { name: key, scope: SCOPES[key], settings: value}
  end

  def to_plist
    {
      author: @author,
      name: @name,
      settings:  [{ settings: @settings }] + @fields,
      uuid: '766026CB-703D-4610-B070-8DE07D967C5FE'
    }.to_plist
  end

  SCOPES = {
    "Comment" => "comment",
    "Constant" => "constant",
    "Entity" => "entity",
    "Keyword" => "keyword",
    "Storage" => "storage",
    "String" => "string",
    "Support" => "support",
    "Variable" => "variable",
    "Invalid – Deprecated" => "invalid.deprecated",
    "Invalid – Illegal" => "invalid.illegal",
    "♦ Embedded Source" => "text source",
    "♦ Embedded Source (Bright)" => "text.html.ruby source",
    "♦ Entity inherited-class" => "entity.other.inherited-class",
    "♦ String embedded-source" => "string source",
    "♦ String constant" => "string constant",
    "♦ String.regexp" => "string.regexp",
    "♦ String.regexp.«special»" => "string.regexp constant.character.escape, string.regexp source.ruby.embedded, string.regexp string.regexp.arbitrary-repitition",
    "♦ String variable" => "string variable",
    "♦ Support.function" => "support.function",
    "♦ Support.constant" => "support.constant",
    "c C/C++ Preprocessor Line" => "meta.preprocessor.c",
    "c C/C++ Preprocessor Directive" => "meta.preprocessor.c keyword",
    "✘ Doctype/XML Processing" => "meta.tag.sgml.doctype, meta.tag.sgml.doctype entity, meta.tag.sgml.doctype string, meta.tag.preprocessor.xml, meta.tag.preprocessor.xml entity, meta.tag.preprocessor.xml string",
    "✘ Meta.tag.«all»" => "declaration.tag, declaration.tag entity, meta.tag, meta.tag entity",
    "✘ Meta.tag.inline" => "declaration.tag.inline, declaration.tag.inline entity, source entity.name.tag, source entity.other.attribute-name, meta.tag.inline, meta.tag.inline entity",
    "§ css tag-name" => "meta.selector.css entity.name.tag",
    "§ css:pseudo-class" => "meta.selector.css entity.other.attribute-name.tag.pseudo-class",
    "§ css#id" => "meta.selector.css entity.other.attribute-name.id",
    "§ css.class" => "meta.selector.css entity.other.attribute-name.class",
    "§ css property-name:" => "support.type.property-name.css",
    "§ css property-value;" => "meta.property-group support.constant.property-value.css, meta.property-value support.constant.property-value.css",
    "§ css @at-rule" => "meta.preprocessor.at-rule keyword.control.at-rule",
    "§ css additional-constants" => "meta.property-value support.constant.named-color.css, meta.property-value constant",
    "§ css constructor.argument" => "meta.constructor.argument.css",
    "⎇ diff.header" => "meta.diff, meta.diff.header, meta.separator",
    "⎇ diff.deleted" => "markup.deleted",
    "⎇ diff.changed" => "markup.changed",
    "⎇ diff.inserted" => "markup.inserted",
    "Markup: List" => "markup.list",
    "Markup: Heading" => "markup.heading"
  }
end
