package com.attiWell.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.attiWell.goods.vo.GoodsVO;

public interface GoodsService {
   
   public Map<String,List<GoodsVO>> listGoods() throws Exception;
//   categoryList 추가
   public Map<String,List<GoodsVO>> categoryList() throws Exception;
   public Map goodsDetail(String _goods_id) throws Exception;
   public List<String> keywordSearch(String keyword) throws Exception;
   public List<GoodsVO> searchGoods(String searchWord) throws Exception;
//   allGoodsList 추가   
   public List<GoodsVO> allGoodsList(Map condMap) throws Exception;
}