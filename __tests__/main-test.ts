// Copyright (c) HashiCorp, Inc
// SPDX-License-Identifier: MPL-2.0
import "cdktf/lib/testing/adapters/jest"; // Load types for expect matchers
import { Testing } from "cdktf";
import { DnsRecord } from "../.gen/providers/cloudflare/dns-record";
import { Zone } from "../.gen/providers/cloudflare/zone";
import { CloudflareProvider } from "../.gen/providers/cloudflare/provider";
import { MyStack } from "../main";

describe("My CDKTF Application", () => {
  it("should create CloudFlare zones", () => {
    const app = Testing.app();
    const stack = new MyStack(app, "test");
    
    expect(Testing.synth(stack)).toHaveResource(Zone);
    expect(Testing.synth(stack)).toHaveResourceWithProperties(Zone, {
      name: "autolife-robotics.me"
    });
  });

  it("should create DNS records", () => {
    const app = Testing.app();
    const stack = new MyStack(app, "test");
    
    expect(Testing.synth(stack)).toHaveResource(DnsRecord);
    expect(Testing.synth(stack)).toHaveResourceWithProperties(DnsRecord, {
      name: "frp-dashboard",
      content: "47.128.253.85",
      type: "A"
    });
  });

  it("should have CloudFlare provider", () => {
    const app = Testing.app();
    const stack = new MyStack(app, "test");
    
    expect(Testing.synth(stack)).toHaveProvider(CloudflareProvider);
  });
});
