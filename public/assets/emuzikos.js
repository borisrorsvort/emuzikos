(function(b,c){var a;b.rails=a={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote]",selectChangeSelector:"select[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])",disableSelector:"input[data-disable-with], button[data-disable-with], textarea[data-disable-with]",enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled",requiredInputSelector:"input[name][required]:not([disabled]),textarea[name][required]:not([disabled])",fileInputSelector:"input:file",CSRFProtection:function(e){var d=b('meta[name="csrf-token"]').attr("content");if(d){e.setRequestHeader("X-CSRF-Token",d)}},fire:function(g,d,f){var e=b.Event(d);g.trigger(e,f);return e.result!==false},confirm:function(d){return confirm(d)},ajax:function(d){return b.ajax(d)},handleRemote:function(g){var k,e,j,h=g.data("cross-domain")||null,d=g.data("type")||(b.ajaxSettings&&b.ajaxSettings.dataType);if(a.fire(g,"ajax:before")){if(g.is("form")){k=g.attr("method");e=g.attr("action");j=g.serializeArray();var f=g.data("ujs:submit-button");if(f){j.push(f);g.data("ujs:submit-button",null)}}else{if(g.is("select")){k=g.data("method");e=g.data("url");j=g.serialize();if(g.data("params")){j=j+"&"+g.data("params")}}else{k=g.data("method");e=g.attr("href");j=g.data("params")||null}}options={type:k||"GET",data:j,dataType:d,crossDomain:h,beforeSend:function(m,l){if(l.dataType===c){m.setRequestHeader("accept","*/*;q=0.5, "+l.accepts.script)}return a.fire(g,"ajax:beforeSend",[m,l])},success:function(m,l,n){g.trigger("ajax:success",[m,l,n])},complete:function(m,l){g.trigger("ajax:complete",[m,l])},error:function(n,l,m){g.trigger("ajax:error",[n,l,m])}};if(e){b.extend(options,{url:e})}a.ajax(options)}},handleMethod:function(h){var e=h.attr("href"),k=h.data("method"),f=b("meta[name=csrf-token]").attr("content"),j=b("meta[name=csrf-param]").attr("content"),g=b('<form method="post" action="'+e+'"></form>'),d='<input name="_method" value="'+k+'" type="hidden" />';if(j!==c&&f!==c){d+='<input name="'+j+'" value="'+f+'" type="hidden" />'}g.hide().append(d).appendTo("body");g.submit()},disableFormElements:function(d){d.find(a.disableSelector).each(function(){var e=b(this),f=e.is("button")?"html":"val";e.data("ujs:enable-with",e[f]());e[f](e.data("disable-with"));e.attr("disabled","disabled")})},enableFormElements:function(d){d.find(a.enableSelector).each(function(){var e=b(this),f=e.is("button")?"html":"val";if(e.data("ujs:enable-with")){e[f](e.data("ujs:enable-with"))}e.removeAttr("disabled")})},allowAction:function(d){var e=d.data("confirm"),f=false,g;if(!e){return true}if(a.fire(d,"confirm")){f=a.confirm(e);g=a.fire(d,"confirm:complete",[f])}return f&&g},blankInputs:function(j,f,h){var e=b(),g,d=f||"input,textarea";j.find(d).each(function(){g=b(this);if(h?g.val():!g.val()){e=e.add(g)}});return e.length?e:false},nonBlankInputs:function(e,d){return a.blankInputs(e,d,true)},stopEverything:function(d){b(d.target).trigger("ujs:everythingStopped");d.stopImmediatePropagation();return false},callFormSubmitBindings:function(e){var d=e.data("events"),f=true;if(d!==c&&d.submit!==c){b.each(d.submit,function(g,h){if(typeof h.handler==="function"){return f=h.handler(h.data)}})}return f}};if("ajaxPrefilter" in b){b.ajaxPrefilter(function(d,f,e){if(!d.crossDomain){a.CSRFProtection(e)}})}else{b(document).ajaxSend(function(f,g,d){if(!d.crossDomain){a.CSRFProtection(g)}})}b(a.linkClickSelector).live("click.rails",function(f){var d=b(this);if(!a.allowAction(d)){return a.stopEverything(f)}if(d.data("remote")!==c){a.handleRemote(d);return false}else{if(d.data("method")){a.handleMethod(d);return false}}});b(a.selectChangeSelector).live("change.rails",function(f){var d=b(this);if(!a.allowAction(d)){return a.stopEverything(f)}a.handleRemote(d);return false});b(a.formSubmitSelector).live("submit.rails",function(j){var g=b(this),h=g.data("remote")!==c,f=a.blankInputs(g,a.requiredInputSelector),d=a.nonBlankInputs(g,a.fileInputSelector);if(!a.allowAction(g)){return a.stopEverything(j)}if(f&&a.fire(g,"ajax:aborted:required",[f])){return a.stopEverything(j)}if(h){if(d){return a.fire(g,"ajax:aborted:file",[d])}if(!b.support.submitBubbles&&a.callFormSubmitBindings(g)===false){return a.stopEverything(j)}a.handleRemote(g);return false}else{setTimeout(function(){a.disableFormElements(g)},13)}});b(a.formInputClickSelector).live("click.rails",function(f){var e=b(this);if(!a.allowAction(e)){return a.stopEverything(f)}var d=e.attr("name"),g=d?{name:d,value:e.val()}:null;e.closest("form").data("ujs:submit-button",g)});b(a.formSubmitSelector).live("ajax:beforeSend.rails",function(d){if(this==d.target){a.disableFormElements(b(this))}});b(a.formSubmitSelector).live("ajax:complete.rails",function(d){if(this==d.target){a.enableFormElements(b(this))}})})(jQuery);(function(c){function a(d){if(d.attr("title")||typeof(d.attr("original-title"))!="string"){d.attr("original-title",d.attr("title")||"").removeAttr("title")}}function b(e,d){this.$element=c(e);this.options=d;this.enabled=true;a(this.$element)}b.prototype={show:function(){var g=this.getTitle();if(g&&this.enabled){var f=this.tip();f.find(".tipsy-inner")[this.options.html?"html":"text"](g);f[0].className="tipsy";f.remove().css({top:0,left:0,visibility:"hidden",display:"block"}).appendTo(document.body);var k=c.extend({},this.$element.offset(),{width:this.$element[0].offsetWidth,height:this.$element[0].offsetHeight});var d=f[0].offsetWidth,j=f[0].offsetHeight;var h=(typeof this.options.gravity=="function")?this.options.gravity.call(this.$element[0]):this.options.gravity;var e;switch(h.charAt(0)){case"n":e={top:k.top+k.height+this.options.offset,left:k.left+k.width/2-d/2};break;case"s":e={top:k.top-j-this.options.offset,left:k.left+k.width/2-d/2};break;case"e":e={top:k.top+k.height/2-j/2,left:k.left-d-this.options.offset};break;case"w":e={top:k.top+k.height/2-j/2,left:k.left+k.width+this.options.offset};break}if(h.length==2){if(h.charAt(1)=="w"){e.left=k.left+k.width/2-15}else{e.left=k.left+k.width/2-d+15}}f.css(e).addClass("tipsy-"+h);if(this.options.fade){f.stop().css({opacity:0,display:"block",visibility:"visible"}).animate({opacity:this.options.opacity})}else{f.css({visibility:"visible",opacity:this.options.opacity})}}},hide:function(){if(this.options.fade){this.tip().stop().fadeOut(function(){c(this).remove()})}else{this.tip().remove()}},getTitle:function(){var f,d=this.$element,e=this.options;a(d);var f,e=this.options;if(typeof e.title=="string"){f=d.attr(e.title=="title"?"original-title":e.title)}else{if(typeof e.title=="function"){f=e.title.call(d[0])}}f=(""+f).replace(/(^\s*|\s*$)/,"");return f||e.fallback},tip:function(){if(!this.$tip){this.$tip=c('<div class="tipsy"></div>').html('<div class="tipsy-arrow"></div><div class="tipsy-inner"/></div>')}return this.$tip},validate:function(){if(!this.$element[0].parentNode){this.hide();this.$element=null;this.options=null}},enable:function(){this.enabled=true},disable:function(){this.enabled=false},toggleEnabled:function(){this.enabled=!this.enabled}};c.fn.tipsy=function(h){if(h===true){return this.data("tipsy")}else{if(typeof h=="string"){return this.data("tipsy")[h]()}}h=c.extend({},c.fn.tipsy.defaults,h);function g(l){var m=c.data(l,"tipsy");if(!m){m=new b(l,c.fn.tipsy.elementOptions(l,h));c.data(l,"tipsy",m)}return m}function k(){var l=g(this);l.hoverState="in";if(h.delayIn==0){l.show()}else{setTimeout(function(){if(l.hoverState=="in"){l.show()}},h.delayIn)}}function f(){var l=g(this);l.hoverState="out";if(h.delayOut==0){l.hide()}else{setTimeout(function(){if(l.hoverState=="out"){l.hide()}},h.delayOut)}}if(!h.live){this.each(function(){g(this)})}if(h.trigger!="manual"){var d=h.live?"live":"bind",j=h.trigger=="hover"?"mouseenter":"focus",e=h.trigger=="hover"?"mouseleave":"blur";this[d](j,k)[d](e,f)}return this};c.fn.tipsy.defaults={delayIn:0,delayOut:0,fade:false,fallback:"",gravity:"n",html:false,live:false,offset:0,opacity:0.8,title:"title",trigger:"hover"};c.fn.tipsy.elementOptions=function(e,d){return c.metadata?c.extend({},d,c(e).metadata()):d};c.fn.tipsy.autoNS=function(){return c(this).offset().top>(c(document).scrollTop()+c(window).height()/2)?"s":"n"};c.fn.tipsy.autoWE=function(){return c(this).offset().left>(c(document).scrollLeft()+c(window).width()/2)?"e":"w"}})(jQuery);(function(a){a.fn.noisy=function(q){q=a.extend({},a.fn.noisy.defaults,q);var p,r;if(JSON&&localStorage.getItem){r=localStorage.getItem(JSON.stringify(q))}if(r){p=r}else{r=document.createElement("canvas");if(r.getContext){r.width=r.height=q.size;for(var l=r.getContext("2d"),o=l.createImageData(r.width,r.height),k=q.intensity*Math.pow(q.size,2),c=255*q.opacity;k--;){var n=(~~(Math.random()*r.width)+~~(Math.random()*r.height)*o.width)*4,m=k%255;o.data[n]=m;o.data[n+1]=q.monochrome?m:~~(Math.random()*255);o.data[n+2]=q.monochrome?m:~~(Math.random()*255);o.data[n+3]=~~(Math.random()*c)}l.putImageData(o,0,0);p=r.toDataURL("image/png");if(p.indexOf("data:image/png")!=0||a.browser.msie&&a.browser.version.substr(0,1)<9&&p.length>32768){p=q.fallback}}else{p=q.fallback}JSON&&localStorage&&localStorage.setItem(JSON.stringify(q),p)}return this.each(function(){a(this).css("background-image","url('"+p+"'),"+a(this).css("background-image"))})};a.fn.noisy.defaults={intensity:0.9,size:200,opacity:0.08,fallback:"",monochrome:false}})(jQuery);(function(b){b.gritter={};b.gritter.options={fade_in_speed:"medium",fade_out_speed:1000,time:6000};b.gritter.add=function(f){try{return a.add(f||{})}catch(d){var c="Gritter Error: "+d;(typeof(console)!="undefined"&&console.error)?console.error(c,f):alert(c)}};b.gritter.remove=function(d,c){a.removeSpecific(d,c||{})};b.gritter.removeAll=function(c){a.stop(c||{})};var a={fade_in_speed:"",fade_out_speed:"",time:"",_custom_timer:0,_item_count:0,_is_setup:0,_tpl_close:'<div class="gritter-close"></div>',_tpl_item:'<div id="gritter-item-[[number]]" class="gritter-item-wrapper [[item_class]]" style="display:none"><div class="gritter-top"></div><div class="gritter-item">[[image]]<div class="[[class_name]]"><span class="gritter-title">[[username]]</span><p>[[text]]</p></div><div style="clear:both"></div></div><div class="gritter-bottom"></div></div>',_tpl_wrap:'<div id="gritter-notice-wrapper"></div>',add:function(f){if(!f.title||!f.text){throw'You need to fill out the first 2 params: "title" and "text"'}if(!this._is_setup){this._runSetup()}var j=f.title,n=f.text,e=f.image||"",l=f.sticky||false,m=f.class_name||"",d=f.time||"";this._verifyWrapper();this._item_count++;var g=this._item_count,k=this._tpl_item;b(["before_open","after_open","before_close","after_close"]).each(function(p,q){a["_"+q+"_"+g]=(b.isFunction(f[q]))?f[q]:function(){}});this._custom_timer=0;if(d){this._custom_timer=d}var c=(e!="")?'<img src="'+e+'" class="gritter-image" />':"",h=(e!="")?"gritter-with-image":"gritter-without-image";k=this._str_replace(["[[username]]","[[text]]","[[image]]","[[number]]","[[class_name]]","[[item_class]]"],[j,n,c,this._item_count,h,m],k);this["_before_open_"+g]();b("#gritter-notice-wrapper").append(k);var o=b("#gritter-item-"+this._item_count);o.fadeIn(this.fade_in_speed,function(){a["_after_open_"+g](b(this))});if(!l){this._setFadeTimer(o,g)}b(o).bind("mouseenter mouseleave",function(p){if(p.type=="mouseenter"){if(!l){a._restoreItemIfFading(b(this),g)}}else{if(!l){a._setFadeTimer(b(this),g)}}a._hoverState(b(this),p.type)});return g},_countRemoveWrapper:function(c,d){d.remove();this["_after_close_"+c](d);if(b(".gritter-item-wrapper").length==0){b("#gritter-notice-wrapper").remove()}},_fade:function(f,c,h,d){var h=h||{},g=(typeof(h.fade)!="undefined")?h.fade:true;fade_out_speed=h.speed||this.fade_out_speed;this["_before_close_"+c](f);if(d){f.unbind("mouseenter mouseleave")}if(g){f.animate({opacity:0},fade_out_speed,function(){f.animate({height:0},300,function(){a._countRemoveWrapper(c,f)})})}else{this._countRemoveWrapper(c,f)}},_hoverState:function(f,d){if(d=="mouseenter"){f.addClass("hover");var c=f.find("img");(c.length)?c.before(this._tpl_close):f.find("span").before(this._tpl_close);f.find(".gritter-close").click(function(){var e=f.attr("id").split("-")[2];a.removeSpecific(e,{},f,true)})}else{f.removeClass("hover");f.find(".gritter-close").remove()}},removeSpecific:function(c,g,f,d){if(!f){var f=b("#gritter-item-"+c)}this._fade(f,c,g||{},d)},_restoreItemIfFading:function(d,c){clearTimeout(this["_int_id_"+c]);d.stop().css({opacity:""})},_runSetup:function(){for(opt in b.gritter.options){this[opt]=b.gritter.options[opt]}this._is_setup=1},_setFadeTimer:function(f,d){var c=(this._custom_timer)?this._custom_timer:this.time;this["_int_id_"+d]=setTimeout(function(){a._fade(f,d)},c)},stop:function(e){var c=(b.isFunction(e.before_close))?e.before_close:function(){};var f=(b.isFunction(e.after_close))?e.after_close:function(){};var d=b("#gritter-notice-wrapper");c(d);d.fadeOut(function(){b(this).remove();f()})},_str_replace:function(v,e,o,n){var k=0,h=0,t="",m="",g=0,q=0,l=[].concat(v),c=[].concat(e),u=o,d=c instanceof Array,p=u instanceof Array;u=[].concat(u);if(n){this.window[n]=0}for(k=0,g=u.length;k<g;k++){if(u[k]===""){continue}for(h=0,q=l.length;h<q;h++){t=u[k]+"";m=d?(c[h]!==undefined?c[h]:""):c[0];u[k]=(t).split(l[h]).join(m);if(n&&u[k]!==t){this.window[n]+=(t.length-u[k].length)/l[h].length}}}return p?u:u[0]},_verifyWrapper:function(){if(b("#gritter-notice-wrapper").length==0){b("body").append(this._tpl_wrap)}}}})(jQuery);(function(a){var c=a.event,b;c.special.smartresize={setup:function(){a(this).bind("resize",c.special.smartresize.handler)},teardown:function(){a(this).unbind("resize",c.special.smartresize.handler)},handler:function(f,e){var h=this,k=arguments;f.type="smartresize";b&&clearTimeout(b);b=setTimeout(function(){jQuery.event.handle.apply(h,k)},e==="execAsap"?0:100)}};a.fn.smartresize=function(d){return d?this.bind("smartresize",d):this.trigger("smartresize",["execAsap"])};a.fn.masonry=function(e,d){var f={getBricks:function(j,g,h){var k=h.itemSelector===undefined;g.$bricks=h.appendedContent===undefined?k?j.children():j.find(h.itemSelector):k?h.appendedContent:h.appendedContent.filter(h.itemSelector)},placeBrick:function(p,r,s,q,n){r=Math.min.apply(Math,s);for(var l=r+p.outerHeight(true),o=s.length,j=o,g=q.colCount+1-o;o--;){if(s[o]==r){j=o}}p.applyStyle({left:q.colW*j+q.posLeft,top:r},a.extend(true,{},n.animationOptions));for(o=0;o<g;o++){q.colY[j+o]=l}},setup:function(j,g,h){f.getBricks(j,h,g);if(h.masoned){h.previousData=j.data("masonry")}h.colW=g.columnWidth===undefined?h.masoned?h.previousData.colW:h.$bricks.outerWidth(true):g.columnWidth;h.colCount=Math.floor(j.width()/h.colW);h.colCount=Math.max(h.colCount,1)},arrange:function(l,g,j){var m;if(!j.masoned||g.appendedContent!==undefined){j.$bricks.css("position","absolute")}if(j.masoned){j.posTop=j.previousData.posTop;j.posLeft=j.previousData.posLeft}else{l.css("position","relative");var k=a(document.createElement("div"));l.prepend(k);j.posTop=Math.round(k.position().top);j.posLeft=Math.round(k.position().left);k.remove()}if(j.masoned&&g.appendedContent!==undefined){j.colY=j.previousData.colY;for(m=j.previousData.colCount;m<j.colCount;m++){j.colY[m]=j.posTop}}else{j.colY=[];for(m=j.colCount;m--;){j.colY.push(j.posTop)}}a.fn.applyStyle=j.masoned&&g.animate?a.fn.animate:a.fn.css;g.singleMode?j.$bricks.each(function(){var h=a(this);f.placeBrick(h,j.colCount,j.colY,j,g)}):j.$bricks.each(function(){var o=a(this),q=Math.ceil(o.outerWidth(true)/j.colW);q=Math.min(q,j.colCount);if(q===1){f.placeBrick(o,j.colCount,j.colY,j,g)}else{var n=j.colCount+1-q,h=[];for(m=0;m<n;m++){var r=j.colY.slice(m,m+q);h[m]=Math.max.apply(Math,r)}f.placeBrick(o,n,h,j,g)}});j.wallH=Math.max.apply(Math,j.colY);l.applyStyle({height:j.wallH-j.posTop},a.extend(true,[],g.animationOptions));j.masoned||setTimeout(function(){l.addClass("masoned")},1);d.call(j.$bricks);l.data("masonry",j)},resize:function(j,g,h){h.masoned=!!j.data("masonry");var k=j.data("masonry").colCount;f.setup(j,g,h);h.colCount!=k&&f.arrange(j,g,h)}};return this.each(function(){var l=a(this),g={};g.masoned=!!l.data("masonry");var j=g.masoned?l.data("masonry").options:{},m=a.extend({},a.fn.masonry.defaults,j,e),k=j.resizeable;g.options=m.saveOptions?m:j;d=d||function(){};f.getBricks(l,g,m);if(!g.$bricks.length){return this}f.setup(l,m,g);f.arrange(l,m,g);!k&&m.resizeable&&a(window).bind("smartresize.masonry",function(){f.resize(l,m,g)});k&&!m.resizeable&&a(window).unbind("smartresize.masonry")})};a.fn.masonry.defaults={singleMode:false,columnWidth:undefined,itemSelector:undefined,appendedContent:undefined,saveOptions:true,resizeable:true,animate:false,animationOptions:{}}})(jQuery);(function(g){var c=g.browser.msie&&parseInt(g.browser.version)===6&&typeof window.XMLHttpRequest!=="object",a=g.browser.msie&&parseInt(g.browser.version)===7,b=null,e=[];g.modal=function(f,d){return g.modal.impl.init(f,d)};g.modal.close=function(){g.modal.impl.close()};g.modal.focus=function(d){g.modal.impl.focus(d)};g.modal.setContainerDimensions=function(){g.modal.impl.setContainerDimensions()};g.modal.setPosition=function(){g.modal.impl.setPosition()};g.modal.update=function(f,d){g.modal.impl.update(f,d)};g.fn.modal=function(d){return g.modal.impl.init(this,d)};g.modal.defaults={appendTo:"body",focus:true,opacity:50,overlayId:"simplemodal-overlay",overlayCss:{},containerId:"simplemodal-container",containerCss:{},dataId:"simplemodal-data",dataCss:{},minHeight:null,minWidth:null,maxHeight:null,maxWidth:null,autoResize:false,autoPosition:true,zIndex:1000,close:true,closeHTML:'<a class="modalCloseImg" title="Close"></a>',closeClass:"simplemodal-close",escClose:true,overlayClose:false,position:null,persist:false,modal:true,onOpen:null,onShow:null,onClose:null};g.modal.impl={d:{},init:function(f,d){var h=this;if(h.d.data){return false}b=g.browser.msie&&!g.boxModel;h.o=g.extend({},g.modal.defaults,d);h.zIndex=h.o.zIndex;h.occb=false;if(typeof f==="object"){f=f instanceof jQuery?f:g(f);h.d.placeholder=false;if(f.parent().parent().size()>0){f.before(g("<span></span>").attr("id","simplemodal-placeholder").css({display:"none"}));h.d.placeholder=true;h.display=f.css("display");if(!h.o.persist){h.d.orig=f.clone(true)}}}else{if(typeof f==="string"||typeof f==="number"){f=g("<div></div>").html(f)}else{alert("SimpleModal Error: Unsupported data type: "+typeof f);return h}}h.create(f);h.open();g.isFunction(h.o.onShow)&&h.o.onShow.apply(h,[h.d]);return h},create:function(f){var d=this;e=d.getDimensions();if(d.o.modal&&c){d.d.iframe=g('<iframe src="javascript:false;"></iframe>').css(g.extend(d.o.iframeCss,{display:"none",opacity:0,position:"fixed",height:e[0],width:e[1],zIndex:d.o.zIndex,top:0,left:0})).appendTo(d.o.appendTo)}d.d.overlay=g("<div></div>").attr("id",d.o.overlayId).addClass("simplemodal-overlay").css(g.extend(d.o.overlayCss,{display:"none",opacity:d.o.opacity/100,height:d.o.modal?e[0]:0,width:d.o.modal?e[1]:0,position:"fixed",left:0,top:0,zIndex:d.o.zIndex+1})).appendTo(d.o.appendTo);d.d.container=g("<div></div>").attr("id",d.o.containerId).addClass("simplemodal-container").css(g.extend(d.o.containerCss,{display:"none",position:"fixed",zIndex:d.o.zIndex+2})).append(d.o.close&&d.o.closeHTML?g(d.o.closeHTML).addClass(d.o.closeClass):"").appendTo(d.o.appendTo);d.d.wrap=g("<div></div>").attr("tabIndex",-1).addClass("simplemodal-wrap").css({height:"100%",outline:0,width:"100%"}).appendTo(d.d.container);d.d.data=f.attr("id",f.attr("id")||d.o.dataId).addClass("simplemodal-data").css(g.extend(d.o.dataCss,{display:"none"})).appendTo("body");d.setContainerDimensions();d.d.data.appendTo(d.d.wrap);if(c||b){d.fixIE()}},bindEvents:function(){var d=this;g("."+d.o.closeClass).bind("click.simplemodal",function(f){f.preventDefault();d.close()});d.o.modal&&d.o.close&&d.o.overlayClose&&d.d.overlay.bind("click.simplemodal",function(f){f.preventDefault();d.close()});g(document).bind("keydown.simplemodal",function(f){if(d.o.modal&&f.keyCode===9){d.watchTab(f)}else{if(d.o.close&&d.o.escClose&&f.keyCode===27){f.preventDefault();d.close()}}});g(window).bind("resize.simplemodal",function(){e=d.getDimensions();d.o.autoResize?d.setContainerDimensions():d.o.autoPosition&&d.setPosition();if(c||b){d.fixIE()}else{if(d.o.modal){d.d.iframe&&d.d.iframe.css({height:e[0],width:e[1]});d.d.overlay.css({height:e[0],width:e[1]})}}})},unbindEvents:function(){g("."+this.o.closeClass).unbind("click.simplemodal");g(document).unbind("keydown.simplemodal");g(window).unbind("resize.simplemodal");this.d.overlay.unbind("click.simplemodal")},fixIE:function(){var f=this,d=f.o.position;g.each([f.d.iframe||null,!f.o.modal?null:f.d.overlay,f.d.container],function(m,j){if(j){var k=j[0].style;k.position="absolute";if(m<2){k.removeExpression("height");k.removeExpression("width");k.setExpression("height",'document.body.scrollHeight > document.body.clientHeight ? document.body.scrollHeight : document.body.clientHeight + "px"');k.setExpression("width",'document.body.scrollWidth > document.body.clientWidth ? document.body.scrollWidth : document.body.clientWidth + "px"')}else{var l;if(d&&d.constructor===Array){m=d[0]?typeof d[0]==="number"?d[0].toString():d[0].replace(/px/,""):j.css("top").replace(/px/,"");m=m.indexOf("%")===-1?m+' + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"':parseInt(m.replace(/%/,""))+' * ((document.documentElement.clientHeight || document.body.clientHeight) / 100) + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"';if(d[1]){l=typeof d[1]==="number"?d[1].toString():d[1].replace(/px/,"");l=l.indexOf("%")===-1?l+' + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"':parseInt(l.replace(/%/,""))+' * ((document.documentElement.clientWidth || document.body.clientWidth) / 100) + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"'}}else{m='(document.documentElement.clientHeight || document.body.clientHeight) / 2 - (this.offsetHeight / 2) + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"';l='(document.documentElement.clientWidth || document.body.clientWidth) / 2 - (this.offsetWidth / 2) + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"'}k.removeExpression("top");k.removeExpression("left");k.setExpression("top",m);k.setExpression("left",l)}}})},focus:function(f){var d=this;f=f&&g.inArray(f,["first","last"])!==-1?f:"first";var h=g(":input:enabled:visible:"+f,d.d.wrap);setTimeout(function(){h.length>0?h.focus():d.d.wrap.focus()},10)},getDimensions:function(){var d=g(window);return[g.browser.opera&&g.browser.version>"9.5"&&g.fn.jquery<"1.3"||g.browser.opera&&g.browser.version<"9.5"&&g.fn.jquery>"1.2.6"?d[0].innerHeight:d.height(),d.width()]},getVal:function(f,d){return f?typeof f==="number"?f:f==="auto"?0:f.indexOf("%")>0?parseInt(f.replace(/%/,""))/100*(d==="h"?e[0]:e[1]):parseInt(f.replace(/px/,"")):null},update:function(f,d){var h=this;if(!h.d.data){return false}h.d.origHeight=h.getVal(f,"h");h.d.origWidth=h.getVal(d,"w");h.d.data.hide();f&&h.d.container.css("height",f);d&&h.d.container.css("width",d);h.setContainerDimensions();h.d.data.show();h.o.focus&&h.focus();h.unbindEvents();h.bindEvents()},setContainerDimensions:function(){var f=this,d=c||a,p=f.d.origHeight?f.d.origHeight:g.browser.opera?f.d.container.height():f.getVal(d?f.d.container[0].currentStyle.height:f.d.container.css("height"),"h");d=f.d.origWidth?f.d.origWidth:g.browser.opera?f.d.container.width():f.getVal(d?f.d.container[0].currentStyle.width:f.d.container.css("width"),"w");var m=f.d.data.outerHeight(true),n=f.d.data.outerWidth(true);f.d.origHeight=f.d.origHeight||p;f.d.origWidth=f.d.origWidth||d;var o=f.o.maxHeight?f.getVal(f.o.maxHeight,"h"):null,l=f.o.maxWidth?f.getVal(f.o.maxWidth,"w"):null;o=o&&o<e[0]?o:e[0];l=l&&l<e[1]?l:e[1];var k=f.o.minHeight?f.getVal(f.o.minHeight,"h"):"auto";p=p?f.o.autoResize&&p>o?o:p<k?k:p:m?m>o?o:f.o.minHeight&&k!=="auto"&&m<k?k:m:k;o=f.o.minWidth?f.getVal(f.o.minWidth,"w"):"auto";d=d?f.o.autoResize&&d>l?l:d<o?o:d:n?n>l?l:f.o.minWidth&&o!=="auto"&&n<o?o:n:o;f.d.container.css({height:p,width:d});f.d.wrap.css({overflow:m>p||n>d?"auto":"visible"});f.o.autoPosition&&f.setPosition()},setPosition:function(){var f=this,d,h;d=e[0]/2-f.d.container.outerHeight(true)/2;h=e[1]/2-f.d.container.outerWidth(true)/2;if(f.o.position&&Object.prototype.toString.call(f.o.position)==="[object Array]"){d=f.o.position[0]||d;h=f.o.position[1]||h}else{d=d;h=h}f.d.container.css({left:h,top:d})},watchTab:function(f){var d=this;if(g(f.target).parents(".simplemodal-container").length>0){d.inputs=g(":input:enabled:visible:first, :input:enabled:visible:last",d.d.data[0]);if(!f.shiftKey&&f.target===d.inputs[d.inputs.length-1]||f.shiftKey&&f.target===d.inputs[0]||d.inputs.length===0){f.preventDefault();d.focus(f.shiftKey?"last":"first")}}else{f.preventDefault();d.focus()}},open:function(){var d=this;d.d.iframe&&d.d.iframe.show();if(g.isFunction(d.o.onOpen)){d.o.onOpen.apply(d,[d.d])}else{d.d.overlay.show();d.d.container.show();d.d.data.show()}d.o.focus&&d.focus();d.bindEvents()},close:function(){var f=this;if(!f.d.data){return false}f.unbindEvents();if(g.isFunction(f.o.onClose)&&!f.occb){f.occb=true;f.o.onClose.apply(f,[f.d])}else{if(f.d.placeholder){var d=g("#simplemodal-placeholder");if(f.o.persist){d.replaceWith(f.d.data.removeClass("simplemodal-data").css("display",f.display))}else{f.d.data.hide().remove();d.replaceWith(f.d.orig)}}else{f.d.data.hide().remove()}f.d.container.hide().remove();f.d.overlay.hide();f.d.iframe&&f.d.iframe.hide().remove();setTimeout(function(){f.d.overlay.remove();f.d={}},10)}}}})(jQuery);(function(h){var m=!1,g=!m,j,k=m,o,f={container:window,currentPage:1,distance:100,pagination:".pagination",params:{},url:location.href,loaderImage:"/images/load.gif"},a=f.container;h.pageless=function(q){h.isFunction(q)?f.call():p(q)};var c=function(){return f.loaderHtml||'<div id="pageless-loader" style="display:none;text-align:center;width:100%;">  <div class="msg" style="color:#e9e9e9;font-size:2em"></div>  <img src="'+f.loaderImage+'" alt="loading more results" style="margin:10px auto" /></div>'};var p=function(q){if(f.inited){return}f.inited=g;if(q){h.extend(f,q)}if(f.pagination){h(f.pagination).remove()}b()};h.fn.pageless=function(s){var r=h(this),q=h(s.loader,r);p(s);j=r;if(s.loader&&q.length){o=q}else{o=h(c());r.append(o);if(!s.loaderHtml){h("#pageless-loader .msg").html(s.loaderMsg)}}};var e=function(q){(k=q)?(o&&o.fadeIn("normal")):(o&&o.fadeOut("normal"))};var d=function(){return(a===window)?h(document).height()-h(a).scrollTop()-h(a).height():h(a)[0].scrollHeight-h(a).scrollTop()-h(a).height()};var l=function(){h(a).unbind(".pageless")};var b=function(){h(a).bind("scroll.pageless",n).trigger("scroll.pageless")};var n=function(){if(f.totalPages<=f.currentPage){l();if(f.end){f.end.call()}return}if(!k&&(d()<f.distance)){e(g);f.currentPage++;h.extend(f.params,{page:f.currentPage});h.get(f.url,f.params,function(q){h.isFunction(f.scrape)?f.scrape(q):q;o?o.before(q):j.append(q);e(m);if(f.complete){f.complete.call()}})}}})(jQuery);var imgSizer={Config:{imgCache:[],spacer:"/path/to/your/spacer.gif"},collate:function(d){var e=(document.all&&!window.opera&&!window.XDomainRequest)?1:0;if(e&&document.getElementsByTagName){var g=imgSizer;var f=g.Config.imgCache;var a=(d&&d.length)?d:document.getElementsByTagName("img");for(var b=0;b<a.length;b++){a[b].origWidth=a[b].offsetWidth;a[b].origHeight=a[b].offsetHeight;f.push(a[b]);g.ieAlpha(a[b]);a[b].style.width="100%"}if(f.length){g.resize(function(){for(var c=0;c<f.length;c++){var h=(f[c].offsetWidth/f[c].origWidth);f[c].style.height=(f[c].origHeight*h)+"px"}})}}},ieAlpha:function(a){var d=imgSizer;if(a.oldSrc){a.src=a.oldSrc}var b=a.src;a.style.width=a.offsetWidth+"px";a.style.height=a.offsetHeight+"px";a.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+b+"', sizingMethod='scale')";a.oldSrc=b;a.src=d.Config.spacer},resize:function(b){var a=window.onresize;if(typeof window.onresize!="function"){window.onresize=b}else{window.onresize=function(){if(a){a()}b()}}}}(function(a){var b=0;a.fn.mobileMenu=function(m){var f={switchWidth:768,topOptionText:"Select a page",indentString:"&nbsp;&nbsp;&nbsp;"};function d(n){return n.is("ul, ol")}function g(){return(a(window).width()<f.switchWidth)}function c(n){if(n.attr("id")){return(a("#mobileMenu_"+n.attr("id")).length>0)}else{b++;n.attr("id","mm"+b);return(a("#mobileMenu_mm"+b).length>0)}}function j(n){if(n.val()!==null){document.location.href=n.val()}}function l(n){n.hide("display","none");a("#mobileMenu_"+n.attr("id")).show()}function k(n){n.css("display","");a("#mobileMenu_"+n.attr("id")).hide()}function h(n){if(d(n)){var o='<select id="mobileMenu_'+n.attr("id")+'" class="mobileMenu">';o+='<option value="">'+f.topOptionText+"</option>";n.find("li").each(function(){var s="";var p=a(this).parents("ul, ol").length;for(i=1;i<p;i++){s+=f.indentString}var q=a(this).find("a:first-child").attr("href");var r=s+a(this).clone().children("ul, ol").remove().end().text();o+='<option value="'+q+'">'+r+"</option>"});o+="</select>";n.parent().append(o);a("#mobileMenu_"+n.attr("id")).change(function(){j(a(this))});l(n)}else{alert("mobileMenu will only work with UL or OL elements!")}}function e(n){if(g()&&!c(n)){h(n)}else{if(g()&&c(n)){l(n)}else{if(!g()&&c(n)){k(n)}}}}return this.each(function(){if(m){a.extend(f,m)}var n=a(this);a(window).resize(function(){e(n)});e(n)})}})(jQuery);
/*!
 * HTML5 Placeholder jQuery Plugin v1.8.2
 * @link http://github.com/mathiasbynens/Placeholder-jQuery-Plugin
 * @author Mathias Bynens <http://mathiasbynens.be/>
 */
(function(f){var e="placeholder" in document.createElement("input"),a="placeholder" in document.createElement("textarea");if(e&&a){f.fn.placeholder=function(){return this};f.fn.placeholder.input=f.fn.placeholder.textarea=true}else{f.fn.placeholder=function(){return this.filter((e?"textarea":":input")+"[placeholder]").bind("focus.placeholder",b).bind("blur.placeholder",d).trigger("blur.placeholder").end()};f.fn.placeholder.input=e;f.fn.placeholder.textarea=a}function c(h){var g={},j=/^jQuery\d+$/;f.each(h.attributes,function(l,k){if(k.specified&&!j.test(k.name)){g[k.name]=k.value}});return g}function b(){var g=f(this);if(g.val()===g.attr("placeholder")&&g.hasClass("placeholder")){if(g.data("placeholder-password")){g.hide().next().attr("id",g.removeAttr("id").data("placeholder-id")).show().focus()}else{g.val("").removeClass("placeholder")}}}function d(h){var m,l=f(this),g=l,k=this.id;if(l.val()===""){if(l.is(":password")){if(!l.data("placeholder-textinput")){try{m=l.clone().attr({type:"text"})}catch(j){m=f("<input>").attr(f.extend(c(this),{type:"text"}))}m.removeAttr("name").data("placeholder-password",true).data("placeholder-id",k).bind("focus.placeholder",b);l.data("placeholder-textinput",m).data("placeholder-id",k).before(m)}l=l.removeAttr("id").hide().prev().attr("id",k).show()}l.addClass("placeholder").val(l.attr("placeholder"))}else{l.removeClass("placeholder")}}f(function(){f("form").bind("submit.placeholder",function(){var g=f(".placeholder",this).each(b);setTimeout(function(){g.each(d)},10)})});f(window).bind("unload.placeholder",function(){f(".placeholder").val("")})}(jQuery));window.MBP=window.MBP||{};MBP.hideUrlBar=function(){/mobile/i.test(navigator.userAgent)&&!pageYOffset&&!location.hash&&setTimeout(function(){window.scrollTo(0,1)},1000)};MBP.fastButton=function(a,b){this.element=a;this.handler=b;a.addEventListener("touchstart",this,false);a.addEventListener("click",this,false)};MBP.fastButton.prototype.handleEvent=function(a){switch(a.type){case"touchstart":this.onTouchStart(a);break;case"touchmove":this.onTouchMove(a);break;case"touchend":this.onClick(a);break;case"click":this.onClick(a);break}};MBP.fastButton.prototype.onTouchStart=function(a){a.stopPropagation();this.element.addEventListener("touchend",this,false);document.body.addEventListener("touchmove",this,false);this.startX=a.touches[0].clientX;this.startY=a.touches[0].clientY;this.element.style.backgroundColor="rgba(0,0,0,.7)"};MBP.fastButton.prototype.onTouchMove=function(a){if(Math.abs(a.touches[0].clientX-this.startX)>10||Math.abs(a.touches[0].clientY-this.startY)>10){this.reset()}};MBP.fastButton.prototype.onClick=function(a){a.stopPropagation();this.reset();this.handler(a);if(a.type=="touchend"){MBP.preventGhostClick(this.startX,this.startY)}this.element.style.backgroundColor=""};MBP.fastButton.prototype.reset=function(){this.element.removeEventListener("touchend",this,false);document.body.removeEventListener("touchmove",this,false);this.element.style.backgroundColor=""};MBP.preventGhostClick=function(a,b){MBP.coords.push(a,b);window.setTimeout(function(){MBP.coords.splice(0,2)},2500)};MBP.ghostClickHandler=function(d){for(var c=0,b=MBP.coords.length;c<b;c+=2){var a=MBP.coords[c];var e=MBP.coords[c+1];if(Math.abs(d.clientX-a)<25&&Math.abs(d.clientY-e)<25){d.stopPropagation();d.preventDefault()}}};document.addEventListener("click",MBP.ghostClickHandler,true);MBP.coords=[];MBP.splash=function(){var a=navigator.platform==="iPad"?"h/":"l/";document.write('<link rel="apple-touch-startup-image" href="/img/'+a+'splash.png" />')};MBP.autogrow=function(c,a){function d(g){var f=this.scrollHeight,h=this.clientHeight;if(f>h){this.style.height=f+3*e+"px"}}var b=(a)?a:12,e=c.currentStyle?c.currentStyle.lineHeight:getComputedStyle(c,null).lineHeight;e=(e.indexOf("px")==-1)?b:parseInt(e,10);c.style.overflow="hidden";c.addEventListener?c.addEventListener("keyup",d,false):c.attachEvent("onkeyup",d)};if(navigator.userAgent.match(/iPhone/i)||navigator.userAgent.match(/iPad/i)){var viewportmeta=document.querySelectorAll('meta[name="viewport"]')[0];if(viewportmeta){viewportmeta.content="width=device-width, minimum-scale=1.0, maximum-scale=1.0";document.body.addEventListener("gesturestart",function(){viewportmeta.content="width=device-width, minimum-scale=0.25, maximum-scale=1.6"},false)}}function addLoadEvent(a){var b=window.onload;if(typeof window.onload!="function"){window.onload=a}else{window.onload=function(){if(b){b()}a()}}}addLoadEvent(function(){if(document.getElementById&&document.getElementsByTagName){var a=document.getElementById("content").getElementsByTagName("img");imgSizer.collate(a)}});$(document).ready(function(){$(".tooltip").tipsy({trigger:"hover",gravity:"s"});$("input.form_guide").tipsy({trigger:"focus",gravity:"w"});$("a[rel='external']").click(function(){window.open($(this).attr("href"));return false});$(".button").button({text:true});$(".button.add").button({icons:{primary:"ui-icon-plus"},text:true});$(".button.add_to_contact_list").button({icons:{primary:"ui-icon-star"},text:true});$(".button.contact").button({icons:{primary:"ui-icon-mail-closed"},text:true});$(".button.contact_from_index").button({icons:{secondary:"ui-icon-comment"},text:false});$(".button.delete").button({icons:{primary:"ui-icon-trash"},text:true});$(".button.submit").button({icons:{secondary:"ui-icon-triangle-1-e"},text:true});$(".button.reset").button({icons:{primary:"ui-icon-arrowreturnthick-1-w"},text:true});$(".button.back").button({icons:{primary:"ui-icon-triangle-1-w"},text:true});$(".tabs").tabs();$(".checkbox_set").buttonset();$("select, input:checkbox, input.radio:radio").uniform();$("#main_nav li a.current").after('<div class="main_nav_current_arrow"></div>');$("#sub_sections li a.current").after('<div class="top_sub_nav_arrow"></div>');$("#footer .inner_footer th").after('<div class="footer_headers_current_arrow"></div>');$(".homepage #content").noisy({intensity:1,size:150,opacity:0.06,fallback:"",monochrome:true});$(".testimonials").masonry({singleMode:true,resizeable:true,animate:true,itemSelector:".testimonial"});$("a[rel=boxy]").click(function(){var a=$(this).attr("href");$(a).modal({overlayCss:{backgroundColor:"#000"},autoResize:false,autoPosition:true,overlayClose:true,maxWidth:380,maxHeight:"80%"})})});