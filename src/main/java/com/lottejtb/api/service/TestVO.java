package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Generated;

import org.codehaus.jackson.annotate.JsonAnyGetter;
import org.codehaus.jackson.annotate.JsonAnySetter;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;

@Generated("org.jsonschema2pojo")
public class TestVO {
	@JsonProperty("testAir")
	private ArrayList<TestIntoTestVO> testAir = new ArrayList<TestIntoTestVO>();
	
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

	@JsonProperty("testAir")
	public ArrayList<TestIntoTestVO> getTestAir() {
		return testAir;
	}

	@JsonProperty("testAir")
	public void setTestAir(ArrayList<TestIntoTestVO> testAir) {
		this.testAir = testAir;
	}

	@JsonAnyGetter
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}

	@JsonAnySetter
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	
	@Override
	public String toString(){
		String str = "{testAir : \"test123\"}";
		
		return str;
	}
	
}
