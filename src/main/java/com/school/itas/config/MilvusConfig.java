package com.school.itas.config;

import io.milvus.client.MilvusServiceClient;
import io.milvus.param.ConnectParam;
import io.milvus.param.IndexType;
import io.milvus.param.MetricType;
import io.milvus.param.collection.*;
import io.milvus.param.index.CreateIndexParam;
import io.milvus.grpc.DataType;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Slf4j
@Configuration
public class MilvusConfig {

    @Value("${milvus.endpoint}")
    private String endpoint;

    @Value("${milvus.token}")
    private String token;

    @Value("${milvus.collection-name}")
    private String collectionName;

    @Value("${milvus.dimension}")
    private int dimension;

    @Bean
    public MilvusServiceClient milvusServiceClient() {
        return new MilvusServiceClient(
                ConnectParam.newBuilder()
                        .withUri(endpoint)
                        .withToken(token)
                        .build()
        );
    }

    @PostConstruct
    public void initCollection() {
        MilvusServiceClient client = new MilvusServiceClient(
                ConnectParam.newBuilder()
                        .withUri(endpoint)
                        .withToken(token)
                        .build()
        );
        boolean exists = client.hasCollection(
                HasCollectionParam.newBuilder().withCollectionName(collectionName).build()
        ).getData();

        if (!exists) {
            FieldType idField = FieldType.newBuilder()
                    .withName("id").withDataType(DataType.Int64)
                    .withPrimaryKey(true).withAutoID(true).build();
            FieldType docIdField = FieldType.newBuilder()
                    .withName("doc_id").withDataType(DataType.Int64).build();
            FieldType chunkIdField = FieldType.newBuilder()
                    .withName("chunk_id").withDataType(DataType.Int64).build();
            FieldType subjectField = FieldType.newBuilder()
                    .withName("subject").withDataType(DataType.VarChar).withMaxLength(64).build();
            FieldType vectorField = FieldType.newBuilder()
                    .withName("vector").withDataType(DataType.FloatVector).withDimension(dimension).build();

            client.createCollection(CreateCollectionParam.newBuilder()
                    .withCollectionName(collectionName)
                    .withFieldTypes(List.of(idField, docIdField, chunkIdField, subjectField, vectorField))
                    .build());

            client.createIndex(CreateIndexParam.newBuilder()
                    .withCollectionName(collectionName)
                    .withFieldName("vector")
                    .withIndexType(IndexType.IVF_FLAT)
                    .withMetricType(MetricType.IP)
                    .withExtraParam("{\"nlist\":128}")
                    .build());

            log.info("Milvus collection '{}' created", collectionName);
        }

        client.loadCollection(
                LoadCollectionParam.newBuilder().withCollectionName(collectionName).build()
        );
    }
}
