package com.attiWell.goods.service;

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
      List<GoodsVO> goodsList=goodsDAO.selectGoodsList("discount");
      goodsMap.put("discount",goodsList);
      goodsList=goodsDAO.selectGoodsList("hot");
      goodsMap.put("hot",goodsList);
      
      goodsList=goodsDAO.selectGoodsList("common");
      goodsMap.put("common",goodsList);
      return goodsMap;
   }
   
//   categoryList �߰�
   public Map<String,List<GoodsVO>> categoryList() throws Exception {
      Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
      List<GoodsVO> goodsList=goodsDAO.selectCategoryList("����ǰ���ǰ");
      goodsMap.put("����ǰ���ǰ",goodsList);
      goodsList=goodsDAO.selectCategoryList("�Ϲݰǰ���ǰ");
      goodsMap.put("�Ϲݰǰ���ǰ",goodsList);      
      goodsList=goodsDAO.selectCategoryList("�ѹ���/Ŀ��");
      goodsMap.put("�ѹ���/Ŀ��",goodsList);
      goodsList=goodsDAO.selectCategoryList("�ǰ�������ǰ");
      goodsMap.put("�ǰ�������ǰ",goodsList);
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
   
   public List<GoodsVO> searchGoods(String searchWord) throws Exception{
      List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
      return goodsList;
   }
   
//   allGoodsList �߰�   
   public List<GoodsVO> allGoodsList() throws Exception{
      List allgoodsList=goodsDAO.allGoodsList();
      return allgoodsList;
   }
   
   
}