package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.VolunteerDTO;

import java.util.List;

@Mapper
public interface VolunteerMapper {
    List<VolunteerDTO> selectVolunteerList(VolunteerDTO params);

    int selectVolunteerTotalCount(VolunteerDTO params);

    VolunteerDTO selectVolunteer(Long volSeq);

    void updateVolunteer(VolunteerDTO volunteer);

    void deleteVolunteer(Long volSeq);

    void insertVolunteer(VolunteerDTO volunteer);
}