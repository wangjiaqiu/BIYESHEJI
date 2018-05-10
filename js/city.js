
/**
 * JSʡ��������
 * @constructor CitySelect
 * @author tugenhua
 * @time 2014-2-22
 * @email 879083421@qq.com
 */

 function CitySelect(options) {
	
	this.config = {
		url       :   "js/city.min.js",
		provId    :   '#prov',
		cityId    :   '#city',
		areaId    :   '#area',
		prov      :   null,
		city      :   null,
		area      :   null,
		required  :   true
	};

	this.cache = {
		select_prehtml  : '',          // ������Ĭ��ѡ��
		city_json       : ''           //  ����json				
	};

	this.init(options);
 }
 
 CitySelect.prototype = {

	constructor : CitySelect,
	
	init: function(options) {
		this.config = $.extend(this.config, options || {});
		var self = this,
			_config = self.config,
			_cache = self.cache;
		
		_cache.select_prehtml = _config.required ? '' : "<option value=''>��ѡ��</option>";

		// ����ʡ�е�����
		if(typeof(_config.url) == 'string') {
			$.getJSON(_config.url, function(json) {
				_cache.city_json = json;
				self._provFunc();
			});
		}else {
			_cache.city_json = _config.url;
			self._provFunc();
		}
	},
	/*
	 * ��Ⱦʡ�ݺ���
	 * @method _provFunc
	 */
	_provFunc: function() {
		var self = this,
			_config = self.config,
			_cache = self.cache;
		
		var html = _cache.select_prehtml;

		// ���� ��ȡʡ��
		$(_cache.city_json.citylist).each(function(i,prov){
			html += "<option value='"+prov.p+"'>"+prov.p+"</option>";
		});
		$(_config.provId).html(html);

		/*
		 * ���д���ʡ�����м���ֵ����ѡ�С���setTimeoutΪ����IE6�����ã�
		 * ����ȡ����selectedIndex����ǰ��һ��
		 */
		t && clearTimeout(t);
		var t = setTimeout(function(){
			if(_config.prov != null) {
				$(_config.provId).val(_config.prov);
				self._cityStart();
				setTimeout(function(){
					if(_config.city != null) {
						$(_config.cityId).val(_config.city);
						self._areaStart();
						setTimeout(function(){
							if(_config.area != null) {
								$(_config.areaId).val(_config.area);
							}
						},1);
					}
				},1);
			}
		},1);

		// ѡ��ʡ��ʱ�����¼�
		$(_config.provId).unbind('change').bind('change',function(){
			self._cityStart();
		});
		// ѡ���м�ʱ�����¼�
		$(_config.cityId).unbind('change').bind('change',function(){
			self._areaStart();
		});
	},
	/*
	 * ��Ⱦ�к���
	 * @method _cityStart
	 */
	_cityStart: function() {
		var self = this,
			_config = self.config,
			_cache = self.cache;
		var prov_id = $(_config.provId).get(0).selectedIndex;
		if(!_config.required){
			prov_id--;
		};
		$(_config.cityId).empty().attr("disabled",true);
		$(_config.areaId).empty().attr("disabled",true);

		if(prov_id < 0 || typeof(_cache.city_json.citylist[prov_id].c)=="undefined"){

			return;
		}
		
		var html = _cache.select_prehtml;

		$.each(_cache.city_json.citylist[prov_id].c,function(i,city){
			html += "<option value='"+city.n+"'>"+city.n+"</option>";
		});
		
		$(_config.cityId).html(html).attr('disabled',false);
		
		self._areaStart();
	},
	/*
	 * ��Ⱦ������
	 * @method _areaStart
	 */
	_areaStart: function(){
		var self = this,
			_config = self.config,
			_cache = self.cache;
		var prov_id=$(_config.provId).get(0).selectedIndex,
			city_id=$(_config.cityId).get(0).selectedIndex;
		if(!_config.required){
			prov_id--;
			city_id--;
		};
		$(_config.areaId).empty().attr("disabled",true);

		if(prov_id<0||city_id<0||typeof(_cache.city_json.citylist[prov_id].c[city_id].a)=="undefined"){
			return;
		};
		var html = _cache.select_prehtml;

		$.each(_cache.city_json.citylist[prov_id].c[city_id].a,function(i,area){
			html += "<option value='"+area.s+"'>"+area.s+"</option>";
		});
		
		$(_config.areaId).html(html).attr('disabled',false);
		
		
	}
 };
