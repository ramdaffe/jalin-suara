/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.dialog.add("paste",function(e){function r(t){var n=new CKEDITOR.dom.document(t.document),r=n.$,i=n.getById("cke_actscrpt");i&&i.remove(),CKEDITOR.env.ie?r.body.contentEditable="true":r.designMode="on",CKEDITOR.env.ie&&CKEDITOR.env.version<8&&n.getWindow().on("blur",function(){r.selection.empty()}),n.on("keydown",function(e){var t=e.data,n=t.getKeystroke(),r;switch(n){case 27:this.hide(),r=1;break;case 9:case CKEDITOR.SHIFT+9:this.changeFocus(1),r=1}r&&t.preventDefault()},this),e.fire("ariaWidget",new CKEDITOR.dom.element(t.frameElement))}var t=e.lang.clipboard,n=CKEDITOR.env.isCustomDomain();return{title:t.title,minWidth:CKEDITOR.env.ie&&CKEDITOR.env.quirks?370:350,minHeight:CKEDITOR.env.quirks?250:245,onShow:function(){this.parts.dialog.$.offsetHeight,this.setupContent()},onHide:function(){CKEDITOR.env.ie&&(this.getParentEditor().document.getBody().$.contentEditable="true")},onLoad:function(){(CKEDITOR.env.ie7Compat||CKEDITOR.env.ie6Compat)&&e.lang.dir=="rtl"&&this.parts.contents.setStyle("overflow","hidden")},onOk:function(){this.commitContent()},contents:[{id:"general",label:e.lang.common.generalTab,elements:[{type:"html",id:"securityMsg",html:'<div style="white-space:normal;width:340px;">'+t.securityMsg+"</div>"},{type:"html",id:"pasteMsg",html:'<div style="white-space:normal;width:340px;">'+t.pasteMsg+"</div>"},{type:"html",id:"editing_area",style:"width: 100%; height: 100%;",html:"",focus:function(){var e=this.getInputElement().$.contentWindow;setTimeout(function(){e.focus()},500)},setup:function(){var i=this.getDialog(),s='<html dir="'+e.config.contentsLangDirection+'"'+' lang="'+(e.config.contentsLanguage||e.langCode)+'">'+"<head><style>body { margin: 3px; height: 95%; } </style></head><body>"+'<script id="cke_actscrpt" type="text/javascript">'+"window.parent.CKEDITOR.tools.callFunction( "+CKEDITOR.tools.addFunction(r,i)+", this );"+"</script></body>"+"</html>",o=CKEDITOR.env.air?"javascript:void(0)":n?"javascript:void((function(){document.open();document.domain='"+document.domain+"';"+"document.close();"+'})())"':"",u=CKEDITOR.dom.element.createFromHtml('<iframe class="cke_pasteframe" frameborder="0"  allowTransparency="true" src="'+o+'"'+' role="region"'+' aria-label="'+t.pasteArea+'"'+' aria-describedby="'+i.getContentElement("general","pasteMsg").domId+'"'+' aria-multiple="true"'+"></iframe>");u.on("load",function(e){e.removeListener();var t=u.getFrameDocument();t.write(s),CKEDITOR.env.air&&r.call(this,t.getWindow().$)},i),u.setCustomData("dialog",i);var f=this.getElement();f.setHtml(""),f.append(u);if(CKEDITOR.env.ie){var l=CKEDITOR.dom.element.createFromHtml('<span tabindex="-1" style="position:absolute;" role="presentation"></span>');l.on("focus",function(){u.$.contentWindow.focus()}),f.append(l),this.focus=function(){l.focus(),this.fire("focus")}}this.getInputElement=function(){return u},CKEDITOR.env.ie&&(f.setStyle("display","block"),f.setStyle("height",u.$.offsetHeight+2+"px"))},commit:function(e){var t=this.getElement(),n=this.getDialog().getParentEditor(),r=this.getInputElement().getFrameDocument().getBody(),i=r.getBogus(),s;i&&i.remove(),s=r.getHtml(),setTimeout(function(){n.fire("paste",{html:s})},0)}}]}]}});