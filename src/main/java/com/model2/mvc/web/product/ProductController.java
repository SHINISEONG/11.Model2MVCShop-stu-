package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		///method for DI
		public void setProductService(ProductService productService) {
			this.productService = productService;
		}
	
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{commonProperties['fileUploadPath']}")
	String fileUploadPath;
			
	///Constructor
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	///RequestMethod
	@RequestMapping("addProduct")
	public String addProduct(@ModelAttribute("product") Product product,
							 MultipartHttpServletRequest files,
							 Model model) throws Exception {
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		List<MultipartFile> fileList = files.getFiles("files");
		if(fileList.get(0).getOriginalFilename().trim() != "") {
			
			
			String filename = "";
		
			for(int i = 0; i<fileList.size(); i++) {
				String ext = fileList.get(i).getOriginalFilename().substring(fileList.get(i).getOriginalFilename().lastIndexOf("."));
				String uuidFileName = UUID.randomUUID().toString()+ext;
				fileList.get(i).transferTo(new File(fileUploadPath+(uuidFileName)));
				filename += (i!=0)?(","+(uuidFileName)):(uuidFileName);
			}
			
			product.setFileName(filename);
		}
		
		System.out.println("¿©±â´Â ¾Öµå ÇÁ·Î´öÆ® ³»ºÎ : " + product.getFileNames());
		productService.addProduct(product);
		boolean addChecker = true;
		model.addAttribute("addChecker", addChecker);
		model.addAttribute("product", product);
		return "forward:/product/getProductView.jsp";
	}
	
	@RequestMapping("getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, 
						     @RequestParam(value="menu", defaultValue="search") String menu, 
						     Model model) throws Exception {
		
		Product product = productService.getProduct(prodNo);
		System.out.println(product + "ÀaŽòµ¤º");
		product.setFileNames();
		
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		return "forward:/product/getProductView.jsp";
	}
	
	@RequestMapping("listProduct")
	public String listProduct(@ModelAttribute("search") Search search , Model model,
							  @RequestParam(value="searchMinPrice", defaultValue = "0") int searchMinPrice, 
							  @RequestParam(value="searchMaxPrice", defaultValue = "0") int searchMaxPrice,
							  @RequestParam(value="searchOrderType", defaultValue = "orderByDateDESC") String searchOrderType,
							  @RequestParam(value="searchCondition", defaultValue = "0") String searchCondition,
							  @RequestParam(value="menu", defaultValue = "manage") String menu 
							  ) throws Exception {
		
		if (searchMaxPrice < searchMinPrice) {
			int tmp=0;
		
			tmp = searchMaxPrice;
			searchMaxPrice = searchMinPrice;
			searchMinPrice = tmp;
		}
		
		search.setSearchOrderType(searchOrderType);
		search.setSearchMinPrice(searchMinPrice);
		search.setSearchMaxPrice(searchMaxPrice);
		search.setSearchCondition(searchCondition);
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		Map<String,Object> map = productService.getProductList(search);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp?menu="+menu;
	}
	
	
	@GetMapping("updateProduct")
	public String updateProduct(@RequestParam("prodNo") int prodNo,
								Model model) throws Exception {
		Product product = productService.getProduct(prodNo);
		String manuDate = product.getManuDate();
		
		product.setManuDate(manuDate.substring(0,4)+"-"+manuDate.substring(4, 6)+"-"+manuDate.substring(6));
		model.addAttribute("product", product);
		return "forward:/product/updateProductView.jsp?menu=manage";
	}
	
	@PostMapping("updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product, 
								MultipartHttpServletRequest files,
								Model model) throws Exception {
		List<MultipartFile> fileList = files.getFiles("files");
		
		if(fileList.get(0).getOriginalFilename().trim() != "") {
		
			String filename = "";
		
			for(int i = 0; i<fileList.size(); i++) {
				String ext = fileList.get(i).getOriginalFilename().substring(fileList.get(i).getOriginalFilename().lastIndexOf("."));
				String uuidFileName = UUID.randomUUID().toString()+ext;
				fileList.get(i).transferTo(new File(fileUploadPath+(uuidFileName)));
				filename += (i!=0)?(","+(uuidFileName)):(uuidFileName);
			}
			product.setFileName(filename);
		}
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		productService.updateProduct(product);
		
		boolean updateChecker = true;
		model.addAttribute("updateChecker", updateChecker);
		
		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=manage";
	}	

}
