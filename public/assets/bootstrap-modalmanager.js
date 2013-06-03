/* ===========================================================
 * bootstrap-modalmanager.js v2.1
 * ===========================================================
 * Copyright 2012 Jordan Schroter.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(e){"use strict";function r(e){return function(t){if(this===t.target)return e.apply(this,arguments)}}var t=function(e,t){this.init(e,t)};t.prototype={constructor:t,init:function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.modalmanager.defaults,this.$element.data(),typeof n=="object"&&n),this.stack=[],this.backdropCount=0;if(this.options.resize){var r,i=this;e(window).on("resize.modal",function(){r&&clearTimeout(r),r=setTimeout(function(){for(var e=0;e<i.stack.length;e++)i.stack[e].isShown&&i.stack[e].layout()},10)})}},createModal:function(t,n){e(t).modal(e.extend({manager:this},n))},appendModal:function(t){this.stack.push(t);var n=this;t.$element.on("show.modalmanager",r(function(r){var i=function(){t.isShown=!0;var r=e.support.transition&&t.$element.hasClass("fade");n.$element.toggleClass("modal-open",n.hasOpenModal()).toggleClass("page-overflow",e(window).height()<n.$element.height()),t.$parent=t.$element.parent(),t.$container=n.createContainer(t),t.$element.appendTo(t.$container),n.backdrop(t,function(){t.$element.show(),t.layout(),t.$element.addClass("in").attr("aria-hidden",!1);var i=function(){n.setFocus(),t.$element.triggerHandler("shown")};r?t.$element.one(e.support.transition.end,i):i()})};t.options.replace?n.replace(i):i()})),t.$element.on("hidden.modalmanager",r(function(r){n.backdrop(t),t.$backdrop?e.support.transition&&t.$element.hasClass("fade")?t.$backdrop.one(e.support.transition.end,function(){n.destroyModal(t)}):n.destroyModal(t):n.destroyModal(t)})),t.$element.on("destroy.modalmanager",r(function(e){n.removeModal(t)}))},destroyModal:function(e){e.destroy();var t=this.hasOpenModal();this.$element.toggleClass("modal-open",t),t||this.$element.removeClass("page-overflow"),this.removeContainer(e),this.setFocus()},hasOpenModal:function(){for(var e=0;e<this.stack.length;e++)if(this.stack[e].isShown)return!0;return!1},setFocus:function(){var e;for(var t=0;t<this.stack.length;t++)this.stack[t].isShown&&(e=this.stack[t]);if(!e)return;e.focus()},removeModal:function(e){e.$element.off(".modalmanager"),e.$backdrop&&this.removeBackdrop.call(e),this.stack.splice(this.getIndexOfModal(e),1)},getModalAt:function(e){return this.stack[e]},getIndexOfModal:function(e){for(var t=0;t<this.stack.length;t++)if(e===this.stack[t])return t},replace:function(t){var n;for(var i=0;i<this.stack.length;i++)this.stack[i].isShown&&(n=this.stack[i]);n?(this.$backdropHandle=n.$backdrop,n.$backdrop=null,t&&n.$element.one("hidden",r(e.proxy(t,this))),n.hide()):t&&t()},removeBackdrop:function(e){e.$backdrop.remove(),e.$backdrop=null},createBackdrop:function(t){var n;return this.$backdropHandle?(n=this.$backdropHandle,n.off(".modalmanager"),this.$backdropHandle=null,this.isLoading&&this.removeSpinner()):n=e('<div class="modal-backdrop '+t+'" />').appendTo(this.$element),n},removeContainer:function(e){e.$container.remove(),e.$container=null},createContainer:function(t){var i;return i=e('<div class="modal-scrollable">').css("z-index",n("modal",t?this.getIndexOfModal(t):this.stack.length)).appendTo(this.$element),t&&t.options.backdrop!="static"?i.on("click.modal",r(function(e){t.hide()})):t&&i.on("click.modal",r(function(e){t.attention()})),i},backdrop:function(t,r){var i=t.$element.hasClass("fade")?"fade":"",s=t.options.backdrop&&this.backdropCount<this.options.backdropLimit;if(t.isShown&&s){var o=e.support.transition&&i&&!this.$backdropHandle;t.$backdrop=this.createBackdrop(i),t.$backdrop.css("z-index",n("backdrop",this.getIndexOfModal(t))),o&&t.$backdrop[0].offsetWidth,t.$backdrop.addClass("in"),this.backdropCount+=1,o?t.$backdrop.one(e.support.transition.end,r):r()}else if(!t.isShown&&t.$backdrop){t.$backdrop.removeClass("in"),this.backdropCount-=1;var u=this;e.support.transition&&t.$element.hasClass("fade")?t.$backdrop.one(e.support.transition.end,function(){u.removeBackdrop(t)}):u.removeBackdrop(t)}else r&&r()},removeSpinner:function(){this.$spinner&&this.$spinner.remove(),this.$spinner=null,this.isLoading=!1},removeLoading:function(){this.$backdropHandle&&this.$backdropHandle.remove(),this.$backdropHandle=null,this.removeSpinner()},loading:function(t){t=t||function(){},this.$element.toggleClass("modal-open",!this.isLoading||this.hasOpenModal()).toggleClass("page-overflow",e(window).height()<this.$element.height());if(!this.isLoading){this.$backdropHandle=this.createBackdrop("fade"),this.$backdropHandle[0].offsetWidth,this.$backdropHandle.css("z-index",n("backdrop",this.stack.length)).addClass("in");var r=e(this.options.spinner).css("z-index",n("modal",this.stack.length)).appendTo(this.$element).addClass("in");this.$spinner=e(this.createContainer()).append(r).on("click.modalmanager",e.proxy(this.loading,this)),this.isLoading=!0,e.support.transition?this.$backdropHandle.one(e.support.transition.end,t):t()}else if(this.isLoading&&this.$backdropHandle){this.$backdropHandle.removeClass("in");var i=this;e.support.transition?this.$backdropHandle.one(e.support.transition.end,function(){i.removeLoading()}):i.removeLoading()}else t&&t(this.isLoading)}};var n=function(){var t,n={};return function(r,i){if(typeof t=="undefined"){var s=e('<div class="modal hide" />').appendTo("body"),o=e('<div class="modal-backdrop hide" />').appendTo("body");n.modal=+s.css("z-index"),n.backdrop=+o.css("z-index"),t=n.modal-n.backdrop,s.remove(),o.remove(),o=s=null}return n[r]+t*i}}();e.fn.modalmanager=function(n,r){return this.each(function(){var i=e(this),s=i.data("modalmanager");s||i.data("modalmanager",s=new t(this,n)),typeof n=="string"&&s[n].apply(s,[].concat(r))})},e.fn.modalmanager.defaults={backdropLimit:999,resize:!0,spinner:'<div class="loading-spinner fade" style="width: 200px; margin-left: -100px;"><div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div></div>'},e.fn.modalmanager.Constructor=t}(jQuery);