package org.xiangtai.main;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xiangtai.pojo.AccessToken;
import org.xiangtai.pojo.Button;
import org.xiangtai.pojo.CommonButton;
import org.xiangtai.pojo.ComplexButton;
import org.xiangtai.pojo.Menu;
import org.xiangtai.pojo.ViewButton;
import org.xiangtai.util.WeixinUtil;

public class MenuManager {
	private static Logger log = LoggerFactory.getLogger(MenuManager.class);

	public static void main(String[] args) {
		String appId = "wx49b20541a9896c89";
		String appSecret = "22c7dada8a89f21501c98fcab1e6ba91";

		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		if (null != at) {
			int result = WeixinUtil.createMenu(getMenu(), at.getToken());

			if (0 == result)
				log.info("�˵������ɹ���");
			else
				log.info("�˵�����ʧ�ܣ������룺" + result);
		}
	}

	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	private static Menu getMenu() {
		ViewButton btn11 = new ViewButton();
		btn11.setName("ע������");
		btn11.setType("view");
		btn11.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx49b20541a9896c89&redirect_uri=http://www.1756ba.com:8099/tpmgr/weixin.jsp&response_type=code&scope=snsapi_base&state=11#wechat_redirect");
		//btn11.setUrl("http://61.153.216.84/TestUrl/index.jsp");
		
		ViewButton btn12 = new ViewButton();
		btn12.setName("�ҵĻ���");
		btn12.setType("view");
		btn12.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx49b20541a9896c89&redirect_uri=http://www.1756ba.com:8099/tpmgr/weixin.jsp&response_type=code&scope=snsapi_base&state=12#wechat_redirect");
		//btn12.setKey("12");
		
		ViewButton btn20 = new ViewButton();
		btn20.setName("����ƽ̨");
		btn20.setType("view");
		btn20.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx49b20541a9896c89&redirect_uri=http://www.1756ba.com:8099/tpmgr/weixin.jsp&response_type=code&scope=snsapi_base&state=20#wechat_redirect");


		ViewButton btn31 = new ViewButton();
		btn31.setName("����·��");
		btn31.setType("view");
		btn31.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx49b20541a9896c89&redirect_uri=http://www.1756ba.com:8099/tpmgr/weixin.jsp&response_type=code&scope=snsapi_base&state=31#wechat_redirect");


		ViewButton btn32 = new ViewButton();
		btn32.setName("�ϱ�·��");
		btn32.setType("view");
		btn32.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx49b20541a9896c89&redirect_uri=http://www.1756ba.com:8099/tpmgr/weixin.jsp&response_type=code&scope=snsapi_base&state=32#wechat_redirect");


		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("��");
		mainBtn1.setSub_button(new Button[] { btn11, btn12 });


		ComplexButton mainBtn3 = new ComplexButton();
		mainBtn3.setName("����");
		mainBtn3.setSub_button(new Button[] { btn31, btn32 });

		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1, btn20, mainBtn3 });

		return menu;
	}
}