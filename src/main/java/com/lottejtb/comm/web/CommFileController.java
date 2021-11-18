package com.lottejtb.comm.web;

import java.io.File;
import java.net.InetAddress;
import java.util.GregorianCalendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.service.CommFileVO;
import com.lottejtb.comm.util.CommFileManager;
import com.lottejtb.framework.common.ConstStat;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class CommFileController{
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "CommFileService")
    protected CommFileService fileService;
    
    private static final Logger logger = Logger.getLogger(CommFileController.class);
    
    /** CKEDITOR 이미지 파일 업로드 **/
    @RequestMapping(value="/CommImageTempUploadAjax.do")
    public void CommImageTempUpload( @ModelAttribute("CommFileVO") CommFileVO fileVo, HttpServletRequest request,  HttpServletResponse response) throws Exception {
        String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
        int result = fileService.confirmImageFile(request, "TEMP");
        GregorianCalendar gc = new GregorianCalendar();
        String milis =  Long.toString(gc.getTimeInMillis());// 밀리초로 바꿔준다
        if ( result > 0 ){
            fileService.insertBitAttFile( request , milis , "TEMP");
            response.setContentType("text/html;charset=EUC-KR"); 
            response.getWriter().print("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction('"+CKEditorFuncNum+"', '/CommFileDownLoad.do?uniquenum=1&tbl=TEMP&parentnum="+milis+"', '업로드가 완료 되었습니다.')</script>");
            response.getWriter().flush();
        }else{
            response.setContentType("text/html;charset=EUC-KR"); 
            response.getWriter().print("<script type='text/javascript'>alert('정상적인 이미지 파일을 업로드하여 주세요.업로드가 실패 하였습니다.')</script>");
            response.getWriter().flush();
        }
    }
    /**파일 업로드**/
    @RequestMapping(value="/CommFileUplodAjax.do")
    public String upLoadFile(@ModelAttribute("CommFileVO") CommFileVO fileVo, HttpServletRequest request,ModelMap model) throws Exception{
        
        String _msg = null;
        int rtn = 0;
        try {
            rtn = fileService.CommUPload(fileVo, request);
            if( rtn < 1 ){
                _msg = ConstStat.CODE_ERR_ERROR;
            }else{
                _msg = ConstStat.CODE_SUCCESS;
            }
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("Upload Error!");
        }
        model.addAttribute("message", _msg);
        return "jsonView";
    }
    
    /** 파일 다운로드 */
    @RequestMapping(value="/CommFileDownLoad.do")
    public String downLoadFile(@ModelAttribute("CommFileVO") CommFileVO fileVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        int    uniqueNum = fileVo.getUniqueNum();
        String parentNum = fileVo.getParentNum();
        String tbl       = fileVo.getTbl();
        
        // 파라미터 필수 값 여부 체크 
        if( !StringUtils.isBlank(Integer.toString(uniqueNum)) && !StringUtils.isBlank(parentNum) && !StringUtils.isBlank(tbl) ){
            // DB에서 파일 정보 가져오기
            CommFileVO result = fileService.selectFileDetail(fileVo);
            String path = result.getFilePath();
            String fileName = result.getAttOrg();
            
            InetAddress LOCALHOST = InetAddress.getLocalHost();
            String HOST_ADDR = LOCALHOST.getHostAddress();
            
            File file = new File(path);
            request.setAttribute("downFile", path);
            request.setAttribute("orginFile", fileName);
            if (file.exists()) {
                try {
                    CommFileManager.downFile(request, response);
                } catch (Exception e) {
                    //e.printStackTrace();
                	System.err.print("FileDown Error!");
                }
            }
            
        }
        // 파일 다운로드 실패
        return "jsonView";
    }
    /*
     * 첨부파일만 삭제
     */
    @RequestMapping(value = "/CommAttFileDeleteAjax.do", method = RequestMethod.POST)
    public String commAttFileDeleteAjax(@ModelAttribute CommFileVO commFileVo, @RequestParam("mode") String mode, ModelMap model) throws Exception {

        String _msg = "";

        if (!mode.equals(ConstStat.MODE_ATT_FILE_DELETE)) {
            _msg = ConstStat.SVC_STAT_BADREQ;
        } else {

            /** 첨부 파일 삭제 진행 **/
            CommFileVO result = fileService.selectFileDetail(commFileVo);
            if (result != null) {
                String FILE_FULL_PATH = result.getFilePath();
                fileService.deleteFileInfo(commFileVo, FILE_FULL_PATH);
                _msg = ConstStat.CODE_SUCCESS;
            } else {
                _msg = ConstStat.CODE_ERR_ERROR;
            }

        }

        model.addAttribute("message", _msg);
        return "jsonView";
    }
}