#基于[openshare](https://github.com/100apps/openshare)的社会化组件
包含第三方登录和分享

* 目前完成微信、微博和qq平台的登录和分享
* 分享部分主要是做了一些小封装，方便调用。
* 第三方登录，在原[openshare](https://github.com/100apps/openshare)里，登录成功后，并没有获取用户信息，这里做了扩展，登录成功后，再去读取用户的相关信息


微信的获取用户信息接口：http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html

微博的获取用户接口：http://open.weibo.com/wiki/2/users/show

QQ的获取用户信息接口：http://wiki.open.qq.com/wiki/v3/user/get_info
