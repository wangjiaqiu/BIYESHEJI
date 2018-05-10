webshims.register("form-validation",function(e,t,i,n,a,r){var o="webkitURL"in i,s=o&&Modernizr.formvalidation&&!t.bugs.bustedValidity,u=s&&parseFloat((navigator.userAgent.match(/Safari\/([\d\.]+)/)||["","999999"])[1],10),l=r.iVal.errorClass||"user-error",c=r.iVal.successClass||"user-success",p=r.iVal.errorWrapperClass||"ws-invalid",d=r.iVal.successWrapperClass||"ws-success",f=r.iVal.errorBoxClass||"ws-errorbox",h={checkbox:1,radio:1},m=e([]),v=function(){return!e.prop(this,"form")},g=function(t){t=e(t);var i,a,r=m;return"radio"==t[0].type&&(a=t.prop("form"),i=t[0].name,r=i?a?e(a).jProp(i):e(n.getElementsByName(i)).filter(v):t,r=r.filter('[type="radio"]')),r},y=function(t,i){var n;return e.each(t,function(t,r){return r?(n=t+e.prop(i,"validationMessage"),!1):a}),n},b=function(e){var t;try{t=n.activeElement.name===e}catch(i){}return t},w={radio:1,checkbox:1,"select-one":1,"select-multiple":1,file:1,date:1,month:1,week:1,text:1},T={time:1,date:1,month:1,datetime:1,week:1,"datetime-local":1},N=function(i){if(r.iVal.sel){var n,o,p,d;if(i.target&&(n=e(i.target).getNativeElement()[0],p=e(n).getShadowElement(),"submit"!=n.type&&e.prop(n,"willValidate")&&("change"!=i.type||!(d=p.prop("type"))||w[d]))){o=e.data(n,"webshimsswitchvalidityclass");var f=function(){if(d||(d=p.prop("type")),!(s&&("change"==i.type||537.36>u)&&T[d]&&e(i.target).is(":focus")||"focusout"==i.type&&"radio"==n.type&&b(n.name))){if(t.refreshCustomValidityRules&&"async"==t.refreshCustomValidityRules(n))return e(n).one("refreshvalidityui",N),a;var r,o,f,m,v,w=e.prop(n,"validity");w.valid?p.hasClass(c)||(r=c,o=l,m="changedvaliditystate",f="changedvalid",h[n.type]&&n.checked&&g(n).not(n).removeClass(o).addClass(r).removeAttr("aria-invalid"),p.removeAttr("aria-invalid"),e.removeData(n,"webshimsinvalidcause")):(v=y(w,n),e.data(n,"webshimsinvalidcause")!=v&&(e.data(n,"webshimsinvalidcause",v),m="changedvaliditystate"),p.hasClass(l)||(r=l,o=c,h[n.type]&&!n.checked&&g(n).not(n).removeClass(o).addClass(r).attr("aria-invalid","true"),p.attr("aria-invalid","true"),f="changedinvalid")),r&&(p.addClass(r).removeClass(o),setTimeout(function(){e(n).trigger(f)},0)),m&&setTimeout(function(){e(n).trigger(m)},0),e.removeData(n,"webshimsswitchvalidityclass")}};o&&clearTimeout(o),"refreshvalidityui"==i.type?f():e.data(n,"webshimsswitchvalidityclass",setTimeout(f,9))}}};e(n.body||"html").on(r.validityUIEvents||"focusout change refreshvalidityui invalid",N).on("reset resetvalui",function(t){var i=e(t.target);i.is("form, fieldset")&&(i=i.jProp("elements")),i.filter(".user-error, .user-success").removeAttr("aria-invalid").removeClass("user-error").removeClass("user-success").getNativeElement().each(function(){e.removeData(this,"webshimsinvalidcause")}).trigger("resetvalidityui")});var x=function(){t.scrollRoot=o||"BackCompat"==n.compatMode?e(n.body):e(n.documentElement)},E=Modernizr.boxSizing||Modernizr["display-table"]||e.support.getSetAttribute||e.support.boxSizing?"minWidth":"width",A="transitionDelay"in n.documentElement.style,k={display:"inline-block",left:0,top:0,marginTop:0,marginLeft:0,marginRight:0,marginBottom:0};x(),t.ready("DOM",x),t.getRelOffset=function(t,i,n){var a,r;return t=e(t),e.swap(e(t)[0],k,function(){e.position&&n&&e.position.getScrollInfo?(n.of||(n.of=i),n.using=function(e,i){t.attr({"data-horizontal":i.horizontal,"data-vertical":i.vertical}),a=e},t.attr({"data-horizontal":"","data-vertical":"","data-my":n.my||"center","data-at":n.at||"center"}),t.position(n)):(a=e(i).offset(),r=t.offset(),a.top-=r.top,a.left-=r.left,a.top+=i.outerHeight())}),a},e.extend(t.wsPopover,{isInElement:function(t,i){return t==i||e.contains(t,i)},show:function(t){if(!this.isVisible){var a=e.Event("wspopoverbeforeshow");if(this.element.trigger(a),!a.isDefaultPrevented()){this.isVisible=!0,t=e(t||this.options.prepareFor).getNativeElement();var r=this,o=e(t).getShadowElement(),s=function(e){clearTimeout(r.timers.repos),r.timers.repos=setTimeout(function(){r.position(o)},e&&"pospopover"==e.type?4:200)};this.clear(),this.element.removeClass("ws-po-visible").css("display","none"),this.prepareFor(t,o),this.position(o),r.timers.show=setTimeout(function(){r.element.css("display",""),r.timers.show=setTimeout(function(){r.element.addClass("ws-po-visible").trigger("wspopovershow")},9)},9),e(n).on("focusin"+this.eventns+" mousedown"+this.eventns,function(e){!r.options.hideOnBlur||r.stopBlur||r.isInElement(r.lastElement[0]||n.body,e.target)||r.isInElement(t[0]||n.body,e.target)||r.isInElement(r.element[0],e.target)||r.hide()}),this.element.off("pospopover").on("pospopover",s),e(i).on("resize"+this.eventns+" pospopover"+this.eventns,s)}}},_getAutoAppendElement:function(){var t=/^(?:span|i|label|b|p|tr|thead|tbody|table|strong|em|ul|ol|dl|html)$/i;return function(i){for(var a,r=i[0],o=n.body;(r=r[a?"offsetParent":"parentNode"])&&1==r.nodeType&&r!=o;)a||t.test(r.nodeName)||(a=r),a&&"hidden"==e.style(r,"overflow")&&"static"!=e.style(r,"position")&&(a=!1);return e(a||o)}}(),prepareFor:function(t,i){var n,a,r=this,o={},s=e.extend(!0,{},this.options,t.jProp("form").data("wspopover")||{},t.data("wspopover"));this.lastOpts=s,this.lastElement=e(t).getShadowFocusElement(),this.prepared&&this.options.prepareFor||(a="element"==s.appendTo?t.parent():"auto"==s.appendTo?this._getAutoAppendElement(t):e(s.appendTo),this.prepared&&a[0]==this.element[0].parentNode||this.element.appendTo(a)),this.element.attr({"data-class":t.prop("className"),"data-id":t.prop("id")}),o[E]=s.constrainWidth?i.outerWidth():"",this.element.css(o),s.hideOnBlur&&(n=function(e){r.stopBlur?e.stopImmediatePropagation():r.hide()},r.timers.bindBlur=setTimeout(function(){r.lastElement.off(r.eventns).on("focusout"+r.eventns+" blur"+r.eventns,n),r.lastElement.getNativeElement().off(r.eventns)},10)),this.prepared=!0},clear:function(){e(i).off(this.eventns),e(n).off(this.eventns),this.element.off("transitionend"+this.eventns),this.stopBlur=!1,this.lastOpts=!1,e.each(this.timers,function(e,t){clearTimeout(t)})},hide:function(){var t=e.Event("wspopoverbeforehide");if(this.element.trigger(t),!t.isDefaultPrevented()&&this.isVisible){this.isVisible=!1;var n=this,a=function(t){t&&"transitionend"==t.type&&(t=t.originalEvent)&&t.target==n.element[0]&&"hidden"==n.element.css("visibility")||(n.element.off("transitionend"+n.eventns).css("display","none").attr({"data-id":"","data-class":"",hidden:"hidden"}),clearTimeout(n.timers.forcehide),e(i).off("resize"+n.eventns))};this.clear(),this.element.removeClass("ws-po-visible").trigger("wspopoverhide"),e(i).on("resize"+this.eventns,a),A&&this.element.off("transitionend"+this.eventns).on("transitionend"+this.eventns,a),n.timers.forcehide=setTimeout(a,A?600:40)}},position:function(e){var i=t.getRelOffset(this.element.removeAttr("hidden"),e,(this.lastOpts||this.options).position);this.element.css(i)}}),t.validityAlert=function(){r.messagePopover.position=e.extend({},{at:"left bottom",my:"left top",collision:"none"},r.messagePopover.position||{});var n=t.objectCreate(t.wsPopover,{},r.messagePopover),a=n.hide.bind(n);return n.element.addClass("validity-alert").attr({role:"alert"}),e.extend(n,{hideDelay:5e3,showFor:function(t,i,n,r){t=e(t).getNativeElement(),this.clear(),this.hide(),r||(this.getMessage(t,i),this.show(t),this.hideDelay&&(this.timers.delayedHide=setTimeout(a,this.hideDelay))),n||this.setFocus(t)},setFocus:function(n){var a=e(n).getShadowFocusElement(),o=t.scrollRoot.scrollTop()+(r.viewportOffset||0),s=a.offset().top-(r.scrollOffset||30),u=function(){try{a[0].focus()}catch(t){}e(i).triggerHandler("pospopover"+this.eventns)};o>s?t.scrollRoot.animate({scrollTop:s-5-(r.viewportOffset||0)},{queue:!1,duration:Math.max(Math.min(600,1.5*(o-s)),80),complete:u}):u()},getMessage:function(e,t){t||(t=e.getErrorMessage()),t?n.contentElement.text(t):this.hide()}}),n}();var S={slide:{show:"slideDown",hide:"slideUp"},fade:{show:"fadeIn",hide:"fadeOut"}};if(S[r.iVal.fx]||(r.iVal.fx="slide"),t.errorbox={create:function(t,i){i||(i=this.getFieldWrapper(t));var n=e("div."+f,i);return n.length||(n=e('<div class="'+f+'" hidden="hidden">'),i.append(n)),i.data("errorbox",n),n},getFieldWrapper:function(i){var n;return r.iVal.fieldWrapper&&(n="function"==typeof r.iVal.fieldWrapper?r.iVal.fieldWrapper.apply(this,arguments):e(i).parent().closest(r.iVal.fieldWrapper),n.length||(n=!1,t.error("could not find fieldwrapper: "+r.iVal.fieldWrapper))),n||(n=e(i).parent().closest(":not(span, label, em, strong, b, i, mark, p)")),n},_createContentMessage:function(){var t={},i=function(i){var n=e(i).data("errortype");return n||e.each(t,function(t,r){return e(i).is(r)?(n=t,!1):a}),n||"defaultMessage"};return e(function(){e.each(e("<input />").prop("validity"),function(e){if("valid"!=e){var i=e.replace(/[A-Z]/,function(e){return"-"+e.toLowerCase()});t[e]="."+i+", ."+e+", ."+e.toLowerCase()+', [data-errortype="'+e+'"]'}})}),function(t,n){var a=!1,r=e(t).data("errormessage")||{};"string"==typeof r&&(r={defaultMessage:r}),e("> *",n).each(function(){var t=i(this);r[t]||(a=!0,r[t]=e(this).html())}),a&&e(t).data("errormessage",r)}}(),get:function(t,i){i||(i=this.getFieldWrapper(t));var n=i.data("errorbox");return n?"string"==typeof n&&(n=e("#"+n),i.data("errorbox",n),this._createContentMessage(t,n)):(n=this.create(t,i),this._createContentMessage(t,n)),n},addSuccess:function(t,i){var n=e.prop(t,"type"),a=function(){var a=h[n]?e.prop(t,"checked"):e(t).val();i[a?"addClass":"removeClass"](d)},r=w[n]?"change":"blur";e(t).off(".recheckvalid").on(r+".recheckinvalid",a),a()},hideError:function(t,i){var n,a=this.getFieldWrapper(t),o=this.get(t,a);return o&&o.jquery&&(e(t).filter("input").off(".recheckinvalid"),!i&&(n=e("input:invalid, select:invalid, textarea:invalid",a)[0])?e(n).trigger("refreshvalidityui"):(a.removeClass(p),o.message="",o[S[r.iVal.fx].hide](function(){e(this).attr({hidden:"hidden"})}))),i||n||this.addSuccess(t,a),a},recheckInvalidInput:function(t){if(r.iVal.recheckDelay&&r.iVal.recheckDelay>90){var i,n=function(){N({type:"input",target:t})};e(t).filter('input:not([type="checkbox"], [type="radio"])').off(".recheckinvalid").on("input.recheckinvalid",function(){clearTimeout(i),i=setTimeout(n,r.iVal.recheckDelay)}).on("focusout.recheckinvalid",function(){clearTimeout(i)})}},showError:function(t){var i=this.getFieldWrapper(t),n=this.get(t,i),a=e(t).getErrorMessage();return n.message!=a&&(n.stop(!0,!0).html("<p>"+a+"</p>"),n.message=a,i.addClass(p).removeClass(d),this.recheckInvalidInput(t),(n.is("[hidden]")||"none"==n.css("display"))&&n.css({display:"none"}).removeAttr("hidden")[S[r.iVal.fx].show]()),i.removeClass(d),e(t).off(".recheckvalid"),i},reset:function(e){this.hideError(e,!0).removeClass(d)},toggle:function(t){e(t).is(":invalid")?this.showError(t):this.hideError(t)}},e(n.body).on({changedvaliditystate:function(i){if(r.iVal.sel){var n=e(i.target).jProp("form");n.is(r.iVal.sel)&&t.errorbox.toggle(i.target)}},resetvalidityui:function(i){if(r.iVal.sel){var n=e(i.target).jProp("form");n.is(r.iVal.sel)&&t.errorbox.reset(i.target)}},firstinvalid:function(i){if(r.iVal.sel&&r.iVal.handleBubble){var n=e(i.target).jProp("form");n.is(r.iVal.sel)&&(i.preventDefault(),"none"!=r.iVal.handleBubble&&t.validityAlert.showFor(i.target,!1,!1,"hide"==r.iVal.handleBubble))}},submit:function(t){return r.iVal.sel&&!r.iVal.noSubmitCheck&&e(t.target).is(r.iVal.sel)&&e.prop(t.target,"noValidate")&&!e(t.target).checkValidity()?(t.stopImmediatePropagation(),!1):a}}),t.modules["form-core"].getGroupElements=g,r.replaceValidationUI&&t.ready("DOM forms",function(){e(n).on("firstinvalid",function(e){e.isInvalidUIPrevented()||(e.preventDefault(),t.validityAlert.showFor(e.target))})}),function(){var t,i,a=[];e(n).on("invalid",function(r){if(!r.wrongWebkitInvalid){var o=e(r.target);if(!t){t=e.Event("firstinvalid"),t.isInvalidUIPrevented=r.isDefaultPrevented;var s=e.Event("firstinvalidsystem");e(n).triggerHandler(s,{element:r.target,form:r.target.form,isInvalidUIPrevented:r.isDefaultPrevented}),o.trigger(t)}t&&t.isDefaultPrevented()&&r.preventDefault(),a.push(r.target),r.extraData="fix",clearTimeout(i),i=setTimeout(function(){var i={type:"lastinvalid",cancelable:!1,invalidlist:e(a)};t=!1,a=[],e(r.target).trigger(i,[i])},9),o=null}})}(),s&&540>u&&function(){var t=/^(?:textarea|input)$/i,a=!1;n.addEventListener("contextmenu",function(e){t.test(e.target.nodeName||"")&&(a=e.target.form)&&setTimeout(function(){a=!1},1)},!1),e(i).on("invalid",function(e){e.originalEvent&&a&&a==e.target.form&&(e.wrongWebkitInvalid=!0,e.stopImmediatePropagation())})}(),!e.event.special.change&&!e.event.special.input&&Modernizr.inputtypes&&r.fixRangeChange){var M={trigger:function(){M.blockElement&&(M.blockElement=!1,setTimeout(function(){M.requestedChange&&M.value!=M.requestedChange.value&&e(M.requestedChange).trigger("change"),M.value=!1},9))},lastValue:!1,updateInputValue:function(e){M.lastValue=e.target.value},triggerInput:function(t){M.lastValue!==!1&&M.lastValue!=t.target.value&&e(t.target).trigger("input")},inputTeardown:function(t){e(t.target).off("input",M.updateInputValue).off("blur",M.inputTeardown),M.lastValue=!1},inputSetup:function(t){"range"==t.target.type&&(M.inputTeardown(t),M.lastValue=t.target.value,e(t.target).on("input",M.updateInputValue).on("blur",M.inputTeardown))}};e.each([{name:"key",evt:"keyup"},{name:"mouse",evt:"mouseup"},{name:"touch",evt:"touchend"}],function(t,i){i.name+"Setup";var a=i.name+"Commit";M[i.name+"Block"]=function(t){M.blockElement||"range"!=t.target.type||(M.blockElement=t.target,M.value=t.target.value,e(M.blockElement).off("blur",M.trigger).on("blur",M.trigger),e(n.body).off(i.evt,M[a]).on(i.evt,M[a]))},M[a]=function(){e(n.body).off(i.evt,M[a]),M.trigger()}}),e(n.body||"html").on({mousedown:M.mouseBlock,"keydown kepress":function(e){45>e.keyCode&&e.keyCode>30&&M.keyBlock(e)},touchstart:M.touchBlock,focusin:M.inputSetup}),e.extend(!0,e.event.special,{change:{handle:function(e){return e.isTrigger||M.blockElement!=e.target?(M.requestedChange==e.target&&(M.requestedChange=!1),e.handleObj.handler.apply(this,arguments),a):(M.requestedChange=e.target,M.triggerInput(e),!1)}},input:{handle:function(){var t,i,n=function(){i&&e(i).off("change",n),t=!1,i=!1},a=function(a){n(a),i=a.target,t=a.target.value,e(a.target).on("change",n)};return function(e){var n;if(!e.isTrigger&&"range"==e.target.type)if(i!=e.target)a(e);else if(i==e.target){if(t==(n=e.target.value))return!1;t=e.target.value}e.handleObj.handler.apply(this,arguments)}}()}})}});