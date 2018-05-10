function phonevail(phone) {

	
	// 对固话验证
	var myreg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;
	if (!myreg.test(phone)) {
		return false;
	}else{
		return true;
	}

}

function mobilevail(phone) {

	
	// 对手机验证
	var reg0=/^13\d{9}$/;
	var reg1=/^153\d{8}$/;
	var reg2=/^180\d{8}$/;
	var reg3=/^181\d{8}$/;
	var reg4=/^189\d{8}$/;
	
	var reg5=/^145\d{8}$/;
	var reg6=/^155\d{8}$/;
	var reg7=/^156\d{8}$/;
	var reg8=/^185\d{8}$/;
	var reg9=/^186\d{8}$/;
	
	var reg10=/^145\d{8}$/;
	var reg11=/^150\d{8}$/;
	var reg12=/^151\d{8}$/;
	var reg13=/^152\d{8}$/;
	var reg14=/^157\d{8}$/;
	var reg15=/^158\d{8}$/;
	var reg16=/^159\d{8}$/;
	var reg17=/^182\d{8}$/;
	var reg18=/^183\d{8}$/;
	var reg19=/^184\d{8}$/;
	var reg20=/^187\d{8}$/;
	var reg21=/^188\d{8}$/;
	
	
	if(reg0.test(phone) || reg1.test(phone) || reg2.test(phone) || reg3.test(phone) || reg4.test(phone)||reg5.test(phone) || reg6.test(phone) || reg7.test(phone) || reg8.test(phone) || reg9.test(phone)||reg10.test(phone) || reg11.test(phone) || reg12.test(phone) || reg13.test(phone) || reg14.test(phone)||reg15.test(phone) || reg16.test(phone) || reg17.test(phone) || reg18.test(phone) || reg19.test(phone) ||reg20.test(phone) || reg21.test(phone)){
		return true;
	}else{
		
		return false;
	}
}