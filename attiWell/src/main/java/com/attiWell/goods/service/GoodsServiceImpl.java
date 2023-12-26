package com.attiWell.goods.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.attiWell.goods.dao.GoodsDAO;
import com.attiWell.goods.vo.GoodsVO;
import com.attiWell.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
   @Autowired
   private GoodsDAO goodsDAO;
   
   public Map<String,List<GoodsVO>> listGoods() throws Exception {
      Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
      List<GoodsVO> goodsList=goodsDAO.selectGoodsList("할인상품");
      goodsMap.put("할인상품",goodsList);
      goodsList=goodsDAO.selectGoodsList("인기상품");
      goodsMap.put("인기상품",goodsList);
      goodsList=goodsDAO.selectGoodsList("일반상품");
      goodsMap.put("일반상품",goodsList);
      return goodsMap;
   }
   
//   categoryList 추가
   public Map<String,List<GoodsVO>> categoryList(Map<String, Object> condMap) throws Exception {
      Map<String, List<GoodsVO>> goodsMap = new HashMap<String, List<GoodsVO>>();
      for (String category : Arrays.asList("전통건강식품", "일반건강식품", "한방차/커피", "건강관리용품")) {
          condMap.put("goodsSort", category);
          List<GoodsVO> goodsList = goodsDAO.selectCategoryList(condMap);
          goodsMap.put(category, goodsList);
      }

      return goodsMap;
   }
   
   public Map goodsDetail(String _goods_id) throws Exception {
      Map goodsMap=new HashMap();
      GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
      goodsMap.put("goodsVO", goodsVO);
      List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
      goodsMap.put("imageList", imageList);
      return goodsMap;
   }
   
   public List<String> keywordSearch(String keyword) throws Exception {
      List<String> list=goodsDAO.selectKeywordSearch(keyword);
      return list;
   }
   
   public List<GoodsVO> searchGoods(Map<String, Object> condMap) throws Exception{
      List goodsList=goodsDAO.selectGoodsBySearchWord(condMap);
      return goodsList;
   }
   
//   allGoodsList 추가   
   public List<GoodsVO> allGoodsList(Map condMap) throws Exception{
      List allgoodsList=goodsDAO.allGoodsList(condMap);
      return allgoodsList;
   }
   
   @Override
   public int getAllGoodsCount() throws Exception {
       int totalCount = goodsDAO.getAllGoodsCount();
       return totalCount;
   }
   
   @Override
   public int countSearchWord(String searchWord) throws Exception {
       int totalCount = goodsDAO.countGoodsBySearchWord(searchWord);
       return totalCount;
   }
   
   
}