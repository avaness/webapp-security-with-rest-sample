package vikram.rest.v1.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class RuleType {
  public final String name;
  public final String rule;

  @JsonCreator
  public RuleType(
      @JsonProperty("name") String name,
      @JsonProperty("rule") String rule
  ) {
    this.name = name;
    this.rule = rule;
  }
}
