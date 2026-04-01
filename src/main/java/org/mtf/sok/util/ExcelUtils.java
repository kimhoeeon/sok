package org.mtf.sok.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook; // ★ 대용량 엑셀 처리 라이브러리

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

public class ExcelUtils {

    public static void download(HttpServletResponse response, String fileName, List<String> headers, List<List<Object>> data) throws IOException {
        // ★ [개선] 메모리에 100행까지만 유지하고 나머지는 디스크에 임시 저장하여 서버 메모리 보호
        SXSSFWorkbook workbook = new SXSSFWorkbook(100);
        Sheet sheet = workbook.createSheet("Sheet1");

        // 헤더 스타일 설정 (배경색, 폰트 굵게)
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);

        // 일반 데이터 스타일 설정 (가운데 정렬)
        CellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setAlignment(HorizontalAlignment.CENTER);

        // ★ [개선] 날짜 전용 데이터 스타일 설정 (엑셀에서 실제 날짜 형식으로 인식하도록 처리)
        CellStyle dateStyle = workbook.createCellStyle();
        dateStyle.setAlignment(HorizontalAlignment.CENTER);
        CreationHelper createHelper = workbook.getCreationHelper();
        dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

        // 1. 헤더(첫 번째 행) 생성
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.size(); i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers.get(i));
            cell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, 5000); // 기본 셀 너비 설정
        }

        // 2. 데이터 행 생성
        int rowNum = 1;
        for (List<Object> rowData : data) {
            Row row = sheet.createRow(rowNum++);
            for (int i = 0; i < rowData.size(); i++) {
                Cell cell = row.createCell(i);
                Object obj = rowData.get(i);

                if (obj instanceof Number) {
                    cell.setCellValue(((Number) obj).doubleValue());
                    cell.setCellStyle(dataStyle);
                } else if (obj instanceof Date) {
                    // ★ [개선] Date 타입 객체가 들어오면 엑셀 고유의 날짜 형식 적용
                    cell.setCellValue((Date) obj);
                    cell.setCellStyle(dateStyle);
                } else if (obj != null) {
                    cell.setCellValue(obj.toString());
                    cell.setCellStyle(dataStyle);
                } else {
                    cell.setCellValue("");
                    cell.setCellStyle(dataStyle);
                }
            }
        }

        // 3. 브라우저로 엑셀 파일 전송
        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + ".xlsx\"");

        workbook.write(response.getOutputStream());

        // ★ [개선] 다운로드 완료 후 디스크에 생성된 임시 파일들을 완벽하게 삭제 (디스크 용량 확보)
        workbook.dispose();
        workbook.close();
    }
}