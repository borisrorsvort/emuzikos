(function(){var c=(/msie/i).test(navigator.userAgent)&&!(/opera/i).test(navigator.userAgent);var b=window.soundcloud={version:"0.1",debug:false,_listeners:[],_redispatch:function(d,o,h){var k,n=this._listeners[d]||[],f="soundcloud:"+d;try{k=this.getPlayer(o)}catch(m){if(this.debug&&window.console){console.error("unable to dispatch widget event "+d+" for the widget id "+o,h,m)}return}if(window.jQuery){jQuery(k).trigger(f,[h])}else{if(window.Prototype){$(k).fire(f,h)}else{}}for(var j=0,g=n.length;j<g;j+=1){n[j].apply(k,[k,h])}if(this.debug&&window.console){console.log(f,d,o,h)}},addEventListener:function(d,e){if(!this._listeners[d]){this._listeners[d]=[]}this._listeners[d].push(e)},removeEventListener:function(f,h){var g=this._listeners[f]||[];for(var e=0,d=g.length;e<d;e+=1){if(g[e]===h){g.splice(e,1)}}},getPlayer:function(g){var d;try{if(!g){throw"The SoundCloud Widget DOM object needs an id atribute, please refer to SoundCloud Widget API documentation."}d=c?window[g]:document[g];if(d){if(d.api_getFlashId){return d}else{throw"The SoundCloud Widget External Interface is not accessible. Check that allowscriptaccess is set to 'always' in embed code"}}else{throw"The SoundCloud Widget with an id "+g+" couldn't be found"}}catch(f){if(console&&console.error){console.error(f)}throw f}},onPlayerReady:function(d,e){this._redispatch("onPlayerReady",d,e)},onMediaStart:function(d,e){this._redispatch("onMediaStart",d,e)},onMediaEnd:function(d,e){this._redispatch("onMediaEnd",d,e)},onMediaPlay:function(d,e){this._redispatch("onMediaPlay",d,e)},onMediaPause:function(d,e){this._redispatch("onMediaPause",d,e)},onMediaBuffering:function(d,e){this._redispatch("onMediaBuffering",d,e)},onMediaSeek:function(d,e){this._redispatch("onMediaSeek",d,e)},onMediaDoneBuffering:function(d,e){this._redispatch("onMediaDoneBuffering",d,e)},onPlayerError:function(d,e){this._redispatch("onPlayerError",d,e)}}})();(function(f){var D=function(K){var L=function(M){return{h:Math.floor(M/(60*60*1000)),m:Math.floor((M/60000)%60),s:Math.floor((M/1000)%60)}}(K),J=[];if(L.h>0){J.push(L.h)}J.push((L.m<10&&L.h>0?"0"+L.m:L.m));J.push((L.s<10?"0"+L.s:L.s));return J.join(".")};var h=function(J){J.sort(function(){return 1-Math.floor(Math.random()*3)});return J};var y=true,c=false,l=f(document),k=function(J){try{if(y&&window.console&&window.console.log){window.console.log.apply(window.console,arguments)}}catch(K){}},I=c?"sandbox-soundcloud.com":"soundcloud.com",p=(document.location.protocol==="https:"),w=function(J,M){var L=(p||(/^https/i).test(J)?"https":"http")+"://api."+I+"/resolve?url=",K="format=json&consumer_key="+M+"&callback=?";if(p){J=J.replace(/^http:/,"https:")}if((/api\./).test(J)){return J+"?"+K}else{return L+J+"&"+K}};var j=function(){var K=function(){var O=false;try{var N=new Audio();O=N.canPlayType&&(/maybe|probably/).test(N.canPlayType("audio/mpeg"))}catch(P){}return O}(),L={onReady:function(){l.trigger("scPlayer:onAudioReady")},onPlay:function(){l.trigger("scPlayer:onMediaPlay")},onPause:function(){l.trigger("scPlayer:onMediaPause")},onEnd:function(){l.trigger("scPlayer:onMediaEnd")},onBuffer:function(N){l.trigger({type:"scPlayer:onMediaBuffering",percent:N})}};var M=function(){var N=new Audio(),O=function(R){var S=R.target,Q=((S.buffered.length&&S.buffered.end(0))/S.duration)*100;L.onBuffer(Q);if(S.currentTime===S.duration){L.onEnd()}},P=function(R){var S=R.target,Q=((S.buffered.length&&S.buffered.end(0))/S.duration)*100;L.onBuffer(Q)};f('<div class="sc-player-engine-container"></div>').appendTo(document.body).append(N);N.addEventListener("play",L.onPlay,false);N.addEventListener("pause",L.onPause,false);N.addEventListener("ended",L.onEnd,false);N.addEventListener("timeupdate",O,false);N.addEventListener("progress",P,false);return{load:function(Q,R){N.pause();N.src=Q.stream_url+(/\?/.test(Q.stream_url)?"&":"?")+"consumer_key="+R;N.load();N.play()},play:function(){N.play()},pause:function(){N.pause()},stop:function(){if(N.currentTime){N.currentTime=0;N.pause()}},seek:function(Q){N.currentTime=N.duration*Q;N.play()},getDuration:function(){return N.duration*1000},getPosition:function(){return N.currentTime*1000},setVolume:function(Q){if(a){a.volume=Q/100}}}};var J=function(){var N="scPlayerEngine",O,P=function(Q){var R=(p?"https":"http")+"://player."+I+"/player.swf?url="+Q+"&amp;enable_api=true&amp;player_type=engine&amp;object_id="+N;if(f.browser.msie){return'<object height="100%" width="100%" id="'+N+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" data="'+R+'"><param name="movie" value="'+R+'" /><param name="allowscriptaccess" value="always" /></object>'}else{return'<object height="100%" width="100%" id="'+N+'"><embed allowscriptaccess="always" height="100%" width="100%" src="'+R+'" type="application/x-shockwave-flash" name="'+N+'" /></object>'}};soundcloud.addEventListener("onPlayerReady",function(Q,R){O=soundcloud.getPlayer(N);L.onReady()});soundcloud.addEventListener("onMediaEnd",L.onEnd);soundcloud.addEventListener("onMediaBuffering",function(Q,R){L.onBuffer(R.percent)});soundcloud.addEventListener("onMediaPlay",L.onPlay);soundcloud.addEventListener("onMediaPause",L.onPause);return{load:function(Q){var R=Q.uri;if(O){O.api_load(R)}else{f('<div class="sc-player-engine-container"></div>').appendTo(document.body).html(P(R))}},play:function(){O&&O.api_play()},pause:function(){O&&O.api_pause()},stop:function(){O&&O.api_stop()},seek:function(Q){O&&O.api_seekTo((O.api_getTrackDuration()*Q))},getDuration:function(){return O&&O.api_getTrackDuration&&O.api_getTrackDuration()*1000},getPosition:function(){return O&&O.api_getTrackPosition&&O.api_getTrackPosition()*1000},setVolume:function(Q){if(O&&O.api_setVolume){O.api_setVolume(Q)}}}};return K?M():J()}();var G,v=false,d=[],r={},F,m=function(N,J,L){var K=0,O={node:N,tracks:[]},M=function(P){var Q=w(P.url,G);f.getJSON(Q,function(R){K+=1;if(R.tracks){O.tracks=O.tracks.concat(R.tracks)}else{if(R.duration){R.permalink_url=P.url;O.tracks.push(R)}else{if(R.creator){J.push({url:R.uri+"/tracks"})}else{if(R.username){if(/favorites/.test(P.url)){J.push({url:R.uri+"/favorites"})}else{J.push({url:R.uri+"/tracks"})}}else{if(f.isArray(R)){O.tracks=O.tracks.concat(R)}}}}}if(J[K]){M(J[K])}else{O.node.trigger({type:"onTrackDataLoaded",playerObj:O,url:Q})}})};G=L;d.push(O);M(J[K])},g=function(J,K){if(K){return'<div class="sc-loading-artwork">Loading Artwork</div>'}else{if(J.artwork_url){return'<img src="'+J.artwork_url.replace("-large","-t300x300")+'"/>'}else{return'<div class="sc-no-artwork">No Artwork</div>'}}},A=function(K,J){f(".sc-info",K).each(function(L){f("h3",this).html('<a href="'+J.permalink_url+'">'+J.title+"</a>");f("h4",this).html('by <a href="'+J.user.permalink_url+'">'+J.user.username+"</a>");f("p",this).html(J.description||"no Description")});f(".sc-artwork-list li",K).each(function(N){var L=f(this),M=L.data("sc-track");if(M===J){L.addClass("active").find(".sc-loading-artwork").each(function(O){f(this).removeClass("sc-loading-artwork").html(g(J,false))})}else{L.removeClass("active")}});f(".sc-duration",K).html(D(J.duration));f(".sc-waveform-container",K).html('<img src="'+J.waveform_url+'" />');K.trigger("onPlayerTrackSwitch.scPlayer",[J])},E=function(J){var K=J.permalink_url;if(F===K){j.play()}else{F=K;j.load(J,G)}},u=function(J){return d[f(J).data("sc-player").id]},t=function(K,J){if(J){f("div.sc-player.playing").removeClass("playing")}f(K).toggleClass("playing",J).trigger((J?"onPlayerPlay":"onPlayerPause"))},x=function(K,L){var J=u(K).tracks[L||0];A(K,J);r={$buffer:f(".sc-buffer",K),$played:f(".sc-played",K),position:f(".sc-position",K)[0]};t(K,true);E(J)},C=function(J){t(J,false);j.pause()},H=function(){var J=r.$played.closest(".sc-player"),K;r.$played.css("width","0%");r.position.innerHTML=D(0);t(J,false);j.stop();J.trigger("onPlayerTrackFinish")},B=function(J,K){j.seek(K);f(J).trigger("onPlayerSeek")},o=function(J){var K=f(J);k("track finished get the next one");$nextItem=f(".sc-trackslist li.active",K).next("li");if(!$nextItem.length){$nextItem=K.nextAll("div.sc-player:first").find(".sc-trackslist li.active")}$nextItem.click()},n=function(){var L=80,J=document.cookie.split(";"),M=new RegExp("scPlayer_volume=(\\d+)");for(var K in J){if(M.test(J[K])){L=parseInt(J[K].match(M)[1],10);break}}return L}(),b=function(L){var K=Math.floor(L);var J=new Date();J.setTime(J.getTime()+(365*24*60*60*1000));n=K;document.cookie=["scPlayer_volume=",K,"; expires=",J.toUTCString(),'; path="/"'].join("");j.setVolume(n)},q;l.bind("scPlayer:onAudioReady",function(J){k("onPlayerReady: audio engine is ready");j.play();b(n)}).bind("scPlayer:onMediaPlay",function(J){clearInterval(q);q=setInterval(function(){var M=j.getDuration(),K=j.getPosition(),L=(K/M);r.$played.css("width",(100*L)+"%");r.position.innerHTML=D(K);l.trigger({type:"onMediaTimeUpdate.scPlayer",duration:M,position:K,relative:L})},500)}).bind("scPlayer:onMediaPause",function(J){clearInterval(q);q=null}).bind("scPlayer:onVolumeChange",function(J){b(J.volume)}).bind("scPlayer:onMediaEnd",function(J){H()}).bind("scPlayer:onMediaBuffering",function(J){r.$buffer.css("width",J.percent+"%")});f.scPlayer=function(T,L){var J=f.extend({},f.scPlayer.defaults,T),M=d.length,Q=L&&f(L),U=Q[0].className.replace("sc-player",""),R=J.links||f.map(f("a",Q).add(Q.filter("a")),function(V){return{url:V.href,title:V.innerHTML}}),N=f('<div class="sc-player loading"></div>').data("sc-player",{id:M}),S=f('<ol class="sc-artwork-list"></ol>').appendTo(N),K=f('<div class="sc-info"><h3></h3><h4></h4><p></p><a href="#" class="sc-info-close">X</a></div>').appendTo(N),P=f('<div class="sc-controls"></div>').appendTo(N),O=f('<ol class="sc-trackslist"></ol>').appendTo(N);if(U||J.customClass){N.addClass(U).addClass(J.customClass)}N.find(".sc-controls").append('<a href="#play" class="sc-play">Play</a> <a href="#pause" class="sc-pause hidden">Pause</a>').end().append('<a href="#info" class="sc-info-toggle">Info</a>').append('<div class="sc-scrubber"></div>').find(".sc-scrubber").append('<div class="sc-volume-slider"><span class="sc-volume-status" style="width:'+n+'%"></span></div>').append('<div class="sc-time-span"><div class="sc-waveform-container"></div><div class="sc-buffer"></div><div class="sc-played"></div></div>').append('<div class="sc-time-indicators"><span class="sc-position"></span> | <span class="sc-duration"></span></div>');m(N,R,J.apiKey);N.bind("onTrackDataLoaded.scPlayer",function(W){var V=W.playerObj.tracks;if(J.randomize){V=h(V)}f.each(V,function(Y,X){var Z=Y===0;f('<li><a href="'+X.permalink_url+'">'+X.title+'</a><span class="sc-track-duration">'+D(X.duration)+"</span></li>").data("sc-track",{id:Y}).toggleClass("active",Z).appendTo(O);f("<li></li>").append(g(X,Y>=J.loadArtworks)).appendTo(S).toggleClass("active",Z).data("sc-track",X)});N.each(function(){if(f.isFunction(J.beforeRender)){J.beforeRender.call(this,V)}});f(".sc-duration",N)[0].innerHTML=D(V[0].duration);f(".sc-position",N)[0].innerHTML=D(0);A(N,V[0]);if(J.continuePlayback){N.bind("onPlayerTrackFinish",function(X){o(N)})}N.removeClass("loading").trigger("onPlayerInit");if(J.autoPlay&&!v){x(N);v=true}});Q.each(function(V){f(this).replaceWith(N)});return N};f.scPlayer.stopAll=function(){f(".sc-player.playing a.sc-pause").click()};f.scPlayer.destroy=function(){f(".sc-player, .sc-player-engine-container").remove()};f.fn.scPlayer=function(J){v=false;this.each(function(){f.scPlayer(J,this)});return this};f.scPlayer.defaults=f.fn.scPlayer.defaults={customClass:null,beforeRender:function(J){var K=f(this)},onDomReady:function(){f("a.sc-player, div.sc-player").scPlayer()},autoPlay:false,continuePlayback:true,randomize:false,loadArtworks:5,apiKey:"htuiRd1JP11Ww0X72T1C3g"};f("a.sc-play, a.sc-pause").live("click",function(K){var J=f(this).closest(".sc-player").find("ol.sc-trackslist");J.find("li.active").click();return false});f("a.sc-info-toggle, a.sc-info-close").live("click",function(K){var J=f(this);J.closest(".sc-player").find(".sc-info").toggleClass("active").end().find("a.sc-info-toggle").toggleClass("active");return false});f(".sc-trackslist li").live("click",function(J){var N=f(this),K=N.closest(".sc-player"),M=N.data("sc-track").id,L=K.is(":not(.playing)")||N.is(":not(.active)");if(L){x(K,M)}else{C(K)}N.addClass("active").siblings("li").removeClass("active");f(".artworks li",K).each(function(O){f(this).toggleClass("active",O===M)});return false});var s=function(M,P){var L=f(M).closest(".sc-time-span"),K=L.find(".sc-buffer"),J=L.find(".sc-waveform-container img"),O=L.closest(".sc-player"),N=Math.min(K.width(),(P-J.offset().left))/J.width();B(O,N)};var e=function(J){if(J.targetTouches.length===1){s(J.target,J.targetTouches&&J.targetTouches.length&&J.targetTouches[0].clientX);J.preventDefault()}};f(".sc-time-span").live("click",function(J){s(this,J.pageX);return false}).live("touchstart",function(J){this.addEventListener("touchmove",e,false);J.originalEvent.preventDefault()}).live("touchend",function(J){this.removeEventListener("touchmove",e,false);J.originalEvent.preventDefault()});var z=function(O,K){var L=f(O),M=L.offset().left,J=L.width(),N=function(Q){return Math.floor(((Q-M)/J)*100)},P=function(Q){l.trigger({type:"scPlayer:onVolumeChange",volume:N(Q.pageX)})};L.bind("mousemove.sc-player",P);P(K)};var i=function(K,J){f(K).unbind("mousemove.sc-player")};f(".sc-volume-slider").live("mousedown",function(J){z(this,J)}).live("mouseup",function(J){i(this,J)});l.bind("scPlayer:onVolumeChange",function(J){f("span.sc-volume-status").css({width:J.volume+"%"})});f(function(){if(f.isFunction(f.scPlayer.defaults.onDomReady)){f.scPlayer.defaults.onDomReady()}})})(jQuery);