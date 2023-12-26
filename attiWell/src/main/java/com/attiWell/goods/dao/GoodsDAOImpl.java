package com.attiWell.goods.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.attiWell.goods.vo.GoodsVO;
import com.attiWell.goods.vo.ImageFileVO;

@Repository("goodsDAO")
public class GoodsDAOImpl  implements GoodsDAO{
   @Autowired
   private SqlSession sqlSession;
   
//   allGoodsList �߰�   
   @Override
   public List<GoodsVO> allGoodsList(Map condMap) throws DataAccessException {
      List<GoodsVO> goodsList = (ArrayList)sqlSession.selectList("mapper.goods.allGoodsList",condMap);
      return goodsList;
   }
   
   @Override
   public int getAllGoodsCount() throws DataAccessException {
       int totalCount = sqlSession.selectOne("mapper.goods.getAllGoodsCount");
       return totalCount;
   }

   @Override
   public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException {
      List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList",goodsStatus);
      return goodsList;   
     
   }
   
//   selectCategoryList �߰�
   @Override
   public List<GoodsVO> selectCategoryList(Map<String, Object> condMap) throws DataAccessException {
      List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectCategoryList",condMap);
      return goodsList;
   }

   
   @Override
   public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
      List<String> list=(ArrayList)sqlSession.selectList("mapper.goods.selectKeywordSearch",keyword);
      return list;
   }
   
   
   @Override
   public List<GoodsVO> selectGoodsBySearchWord(Map<String, Object> condMap) throws DataAccessException{
      List<GoodsVO> list=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsBySearchWord",condMap);
       return list;
   }
   
   @Override
   public int countGoodsBySearchWord(String searchWord) throws DataAccessException{
      int totalCount=sqlSession.selectOne("mapper.goods.countGoodsBySearchWord", searchWord);
       return totalCount;
   }
   
   @Override
   public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException{
      GoodsVO goodsVO=(GoodsVO)sqlSession.selectOne("mapper.goods.selectGoodsDetail",goods_id);
      return goodsVO;
   }
   
   @Override
   public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException{
      List<ImageFileVO> imageList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetailImage",goods_id);
      return imageList;
   }
   
}