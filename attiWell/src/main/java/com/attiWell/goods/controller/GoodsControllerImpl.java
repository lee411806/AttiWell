package com.attiWell.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.attiWell.common.base.BaseController;
import com.attiWell.goods.service.GoodsService;
import com.attiWell.goods.vo.GoodsVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value = "/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController {
	@Autowired
	private GoodsService goodsService;

	@RequestMapping(value = "/goodsDetail.do", method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		Map goodsMap = goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap", goodsMap);
		GoodsVO goodsVO = (GoodsVO) goodsMap.get("goodsVO");
		addGoodsInQuick(goods_id, goodsVO, session);
		return mav;
	}

	@RequestMapping(value = "/keywordSearch.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// System.out.println(keyword);
		if (keyword == null || keyword.equals(""))
			return null;

		keyword = keyword.toUpperCase();
		List<String> keywordList = goodsService.keywordSearch(keyword);

		// 최종 완성될 JSONObject 선언(전체)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);

		String jsonInfo = jsonObject.toString();
		// System.out.println(jsonInfo);
		return jsonInfo;
	}

	@RequestMapping(value = "/searchGoods.do", method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List<GoodsVO> goodsList = goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;

	}

// allGoodsList 추가   (전체상품보기)
	@RequestMapping(value = "/allGoodsList.do", method = RequestMethod.GET)
	public ModelAndView allGoodsList(@RequestParam Map<String, String> dateMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");

		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");

		Map<String, Object> condMap = new HashMap<String, Object>();
		if (section == null) {
			section = "1";
		}
		condMap.put("section", section);
		if (pageNum == null) {
			pageNum = "1";
		}
		condMap.put("pageNum", pageNum);

		List<GoodsVO> goodsList = goodsService.allGoodsList(condMap);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;

	}

//   selectGoodsList 추가(카테고리별)
	@RequestMapping(value = "/selectGoodsList.do", method = RequestMethod.GET)
	public ModelAndView selectGoodsList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "category", required = false, defaultValue = "traditional") String category)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		Map<String, List<GoodsVO>> goodsList = goodsService.categoryList();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		mav.addObject("category", category); // 추가: 선택한 카테고리를 뷰로 전달
		return mav;
	}

	private void addGoodsInQuick(String goods_id, GoodsVO goodsVO, HttpSession session) {
		boolean already_existed = false;
		List<GoodsVO> quickGoodsList; // 최근 본 상품 저장 ArrayList
		quickGoodsList = (ArrayList<GoodsVO>) session.getAttribute("quickGoodsList");

		if (quickGoodsList != null) {
			if (quickGoodsList.size() < 4) { // 미리본 상품 리스트에 상품개수가 세개 이하인 경우
				for (int i = 0; i < quickGoodsList.size(); i++) {
					GoodsVO _goodsBean = (GoodsVO) quickGoodsList.get(i);
					if (goods_id.equals(_goodsBean.getGoods_id())) {
						already_existed = true;
						break;
					}
				}
				if (already_existed == false) {
					quickGoodsList.add(goodsVO);
				}
			}

		} else {
			quickGoodsList = new ArrayList<GoodsVO>();
			quickGoodsList.add(goodsVO);

		}
		session.setAttribute("quickGoodsList", quickGoodsList);
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
	}
}