package com.icia.oauth.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.icia.oauth.api.KakaoJoinApi;
import com.icia.oauth.api.KakaoLoginApi;
import com.icia.oauth.api.NaverJoinApi;
import com.icia.oauth.api.NaverLoginApi;
import com.icia.oauth.service.KakaoService;
import com.icia.oauth.service.NaverService;

@Controller
public class MemberController {

	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private NaverService naverService;
	
	@Autowired
	private NaverJoinApi naverJoinApi;
	
	@Autowired
	private NaverLoginApi naverLoginApi;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	@RequestMapping(value="/kakaojoin", method=RequestMethod.GET)
	public ModelAndView kakaoJoin(HttpSession session) {
		String kakaoUrl = KakaoJoinApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		System.out.println(kakaoUrl);
		mav.setViewName("member/KakaoLogin");
		return mav;
	}
	
	@RequestMapping(value="/naverjoin")
	public ModelAndView naverJoin(HttpSession session) {
		String naverUrl = naverJoinApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");
		return mav;
	}
	
	@RequestMapping(value="/yyskakaoJoinOK")
	public ModelAndView kakaoJoinOK
			(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();
		JsonNode token = KakaoJoinApi.getAccessToken(code);
		JsonNode profile = KakaoJoinApi.getKakaoUserInfo(token.path("access_token"));
		mav = kakaoService.KakaoJoin(profile);		
		return mav;
	}
	
	@RequestMapping(value="/yysnaverJoinOK")
	public ModelAndView naverJoinOK
		(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverJoinApi.getAccessToken(session, code, state);
		String profile = naverJoinApi.getUserProfile(oauthToken);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(profile);
		JSONObject naverUser = (JSONObject) obj;
		JSONObject userInfo = (JSONObject) naverUser.get("response");
		String naverId = (String) userInfo.get("id");
//		String email = (String) userInfo.get("email");
//		String name = (String) userInfo.get("name");
//		String gender = (String) userInfo.get("gender");
//		String birthday = (String) userInfo.get("birthday");
		mav.addObject("naverId", naverId);
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}
	
	@RequestMapping(value="/kakaologin", method=RequestMethod.GET)
	public ModelAndView kakaoLogin(HttpSession session) {
		String kakaoUrl = KakaoLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		System.out.println(kakaoUrl);
		mav.setViewName("member/KakaoLogin");
		return mav;
	}
	
	@RequestMapping(value="/naverlogin")
	public ModelAndView naverLogin(HttpSession session) {
		String naverUrl = naverLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");
		return mav;
	}
	
	@RequestMapping(value="/yyskakaoLoginOK")
	public ModelAndView kakaoLoginOK
			(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();
		JsonNode token = KakaoLoginApi.getAccessToken(code);
		JsonNode profile = KakaoLoginApi.getKakaoUserInfo(token.path("access_token"));
		mav = kakaoService.KakaoLogin(profile);
		return mav;
	}
	
	@RequestMapping(value="/yysnaverLoginOK")
	public ModelAndView naverLoginOK
		(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverLoginApi.getAccessToken(session, code, state);
		String profile = naverLoginApi.getUserProfile(oauthToken);
		mav = naverService.naverLogin(profile);
		return mav;
	}
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String Main() {
		return "Main";
	}

	@RequestMapping(value="/googleJoinForm")
	public ModelAndView SignUpForm(@RequestParam("Gid") String Gid){
		mav = new ModelAndView();
		mav.addObject("Gid", Gid);
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}

	@RequestMapping(value="/facebookJoinForm")
	public ModelAndView SignUpForm2(@RequestParam("Fid") String Fid){
		mav = new ModelAndView();
		mav.addObject("Fid", Fid);
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}

}
