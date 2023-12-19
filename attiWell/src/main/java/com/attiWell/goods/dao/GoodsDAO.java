package com.attiWell.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.attiWell.goods.vo.GoodsVO;
import com.attiWell.goods.vo.ImageFileVO;

public interface GoodsDAO {
//   allGoodsList �߰�   
   public List<GoodsVO> allGoodsList(Map condMap) throws DataAccessException;
   public int getAllGoodsCount() throws DataAccessException;
   public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
//   selectCategoryList �߰�
   public List<GoodsVO> selectCategoryList(Map<String, Object> condMap) throws DataAccessException;
   public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
   public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
   public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
   public List<GoodsVO> selectGoodsBySearchWord(Map<String, Object> condMap) throws DataAccessException;
   public int countGoodsBySearchWord(String searchWord) throws DataAccessException;
}