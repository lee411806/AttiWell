package com.attiWell.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.attiWell.goods.vo.GoodsVO;

public interface GoodsService {
   
   public Map<String,List<GoodsVO>> listGoods() throws Exception;
//   categoryList �߰�
   public Map<String,List<GoodsVO>> categoryList(Map<String, Object> condMap) throws Exception;
   public Map goodsDetail(String _goods_id) throws Exception;
   public List<String> keywordSearch(String keyword) throws Exception;
   public List<GoodsVO> searchGoods(Map<String, Object> condMap) throws Exception;
//   allGoodsList �߰�   
   public List<GoodsVO> allGoodsList(Map condMap) throws Exception;
   public int getAllGoodsCount() throws Exception;
   public int countSearchWord(String searchWord) throws Exception;
}