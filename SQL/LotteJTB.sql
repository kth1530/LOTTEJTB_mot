CREATE TABLE CO_ATTFILE(
  INTNUM    INT PRIMARY KEY                      NOT NULL,
  PARENTNUM INT                                  NOT NULL,
  TBL       VARCHAR(50)                          NOT NULL,
  ATTORG    VARCHAR(150)                         NOT NULL,
  ATTFILE   VARCHAR(150)                         NOT NULL,
  FILEEXT   VARCHAR(50)                          NOT NULL,
  VOLUME    VARCHAR(50)                          NOT NULL,
  FILEPATH  VARCHAR(250)                         NOT NULL,
  FILESIZE  INT             DEFAULT 0            NOT NULL,
  CREATER   VARCHAR(150)                         NOT NULL,
  MIMETYPE  VARCHAR(150)                         NOT NULL,
  WDATE     DATE            DEFAULT SYSDATE      NOT NULL   
);

COMMENT ON TABLE    CO_ATTFILE               IS '첨부공통테이블';
COMMENT ON COLUMN   CO_ATTFILE.INTNUM        IS 'UNIQUE 순번';
COMMENT ON COLUMN   CO_ATTFILE.PARENTNUM     IS '부모 TBL의 UNIQUE 값';
COMMENT ON COLUMN   CO_ATTFILE.TBL           IS '참조 테이블';
COMMENT ON COLUMN   CO_ATTFILE.ATTORG        IS '사용자가업로드한파일명';
COMMENT ON COLUMN   CO_ATTFILE.ATTFILE       IS '서버에저장된파일명';
COMMENT ON COLUMN   CO_ATTFILE.FILEEXT       IS '파일확장자';
COMMENT ON COLUMN   CO_ATTFILE.VOLUME        IS '서버에저장된드라이브경로';
COMMENT ON COLUMN   CO_ATTFILE.FILEPATH      IS '서버저장경로';
COMMENT ON COLUMN   CO_ATTFILE.FILESIZE      IS '파일사이즈';
COMMENT ON COLUMN   CO_ATTFILE.CREATER       IS '등록자';
COMMENT ON COLUMN   CO_ATTFILE.MIMETYPE      IS '파일타입';
COMMENT ON COLUMN   CO_ATTFILE.WDATE         IS '등록일';

COMMIT;