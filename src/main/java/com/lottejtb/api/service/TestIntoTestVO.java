package com.lottejtb.api.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Generated;

import org.codehaus.jackson.annotate.JsonAnyGetter;
import org.codehaus.jackson.annotate.JsonAnySetter;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;

@Generated("org.jsonschema2pojo")
public class TestIntoTestVO {
	
	@JsonProperty("name")
	private String name;
	
	@JsonProperty("id")
	private String id;
	
	@JsonProperty("paxList")
	private List<TestInIntoVo> paxList;
	
	@JsonIgnore
	private Map<String, Object> aitionalProperties = new HashMap<String, Object>();

	@JsonProperty("name")
	public String getName() {
		return name;
	}

	@JsonProperty("name")
	public void setName(String name) {
		this.name = name;
	}

	@JsonProperty("id")
	public String getId() {
		return id;
	}

	@JsonProperty("id")
	public void setId(String id) {
		this.id = id;
	}

	@JsonProperty("paxList")
	public List<TestInIntoVo> getPaxList() {
		return paxList;
	}

	@JsonProperty("paxList")
	public void setPaxList(List<TestInIntoVo> paxList) {
		this.paxList = paxList;
	}

	@JsonAnyGetter
	public Map<String, Object> getAitionalProperties() {
		return aitionalProperties;
	}

	@JsonAnySetter
	public void setAitionalProperties(Map<String, Object> aitionalProperties) {
		this.aitionalProperties = aitionalProperties;
	}
	
}
