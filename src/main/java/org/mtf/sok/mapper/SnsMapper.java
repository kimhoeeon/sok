package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.*;

import java.util.List;

@Mapper
public interface SnsMapper {
    List<BlogDTO> selectBlogList();

    List<InstagramDTO> selectInstagramList();

    void deleteBlog(String date);

    void insertBlogList(List<SaveBlog> blogList);

    void deleteInstagram(String date);

    void insertInstagramList(List<SaveInstagram> blogList);

    String selectInstaToken();

    void updateInstaToken(String token);

    List<String> selectBlogFileNames();

    List<String> selectInstaFileNames();

    InstaTokenDTO selectInstaTokenInfo();
}