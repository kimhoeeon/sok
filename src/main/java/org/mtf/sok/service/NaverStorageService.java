package org.mtf.sok.service;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.UUID;

@Service
public class NaverStorageService {

    private AmazonS3 s3Client;

    // application.properties 에서 값을 읽어옵니다. (없으면 기본값 세팅)
    @Value("${naver.cloud.access-key}")
    private String accessKey;

    @Value("${naver.cloud.secret-key}")
    private String secretKey;

    @Value("${naver.cloud.region:kr-standard}")
    private String region;

    @Value("${naver.cloud.endpoint:https://kr.object.ncloudstorage.com}")
    private String endpoint;

    @Value("${naver.cloud.bucket:sok}") // 발급받을 버킷 이름
    private String bucketName;

    @PostConstruct
    public void init() {
        s3Client = AmazonS3ClientBuilder.standard()
                .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endpoint, region))
                .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
                .build();
    }

    /**
     * 파일을 네이버 클라우드에 업로드하고 외부 접근 URL을 반환합니다.
     */
    public String uploadFile(MultipartFile file, String directoryPath) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String extension = "";

        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        // 파일명 중복 방지를 위한 UUID 부여
        String savedFileName = directoryPath + "/" + UUID.randomUUID().toString() + extension;

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType(file.getContentType());
        metadata.setContentLength(file.getSize());

        // 클라우드에 업로드 (누구나 읽을 수 있도록 PublicRead 권한 부여)
        s3Client.putObject(new PutObjectRequest(bucketName, savedFileName, file.getInputStream(), metadata)
                .withCannedAcl(CannedAccessControlList.PublicRead));

        // 저장된 파일의 URL 링크 반환
        return s3Client.getUrl(bucketName, savedFileName).toString();
    }
}