package org.mtf.sok.controller;

import org.mtf.sok.mapper.StatsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController // JSON 데이터만 반환하는 전용 컨트롤러 선언
@RequestMapping("/mng/api/stats") // 직관적이고 통일된 기본 경로
public class AdminApiController {

    @Autowired
    private StatsMapper statsMapper;

    @GetMapping("/visitor") // 실제 호출 경로: /mng/api/stats/visitor
    public List<Map<String, Object>> getVisitorStats(@RequestParam String period) {
        List<Map<String, Object>> list = statsMapper.selectVisitorTrend(period);
        return fixBase64Label(list);
    }

    @GetMapping("/apply") // 실제 호출 경로: /mng/api/stats/apply
    public List<Map<String, Object>> getApplyStats(@RequestParam String period) {
        List<Map<String, Object>> list = statsMapper.selectApplyTrend(period);
        return fixBase64Label(list);
    }

    // Base64 라벨 보정 로직 (private)
    private List<Map<String, Object>> fixBase64Label(List<Map<String, Object>> list) {
        for (Map<String, Object> map : list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if (entry.getValue() instanceof byte[]) {
                    map.put(entry.getKey(), new String((byte[]) entry.getValue()));
                }
            }
        }
        return list;
    }
}