defmodule DomainTest do
  use ExUnit.Case

  if (not nil? System.get_env("DIGOC_DOMAIN_TEST_NAME")) and 
     (not nil? System.get_env("DIGOC_DOMAIN_TEST_IP")) do
    
       test "test domain functions" do

         ip_address =  System.get_env("DIGOC_DOMAIN_TEST_IP")
         domain_name = System.get_env("DIGOC_DOMAIN_TEST_NAME")

         # create a new domain
         domain = DigOc.domains :new, name: domain_name, ip_address: ip_address
         assert is_record(domain, DigOc.Domain)

         # list domains
         domains = DigOc.domains
         assert is_record(hd(domains), DigOc.Domain)

         # get a domain
         a_domain = DigOc.domains domain.id
         assert a_domain.id == domain.id

         # create a record
         rec = DigOc.domains domain.id, :new_record, 
                                    record_type: "A",
                                    data: ip_address,
                                    name: "dnstest." <> domain_name
         assert is_record(rec, DigOc.DomainRecord)
         assert rec.record_type == "A"
         assert rec.name == "dnstest." <> domain_name

         # edit a record
         newrec = DigOc.domains domain.id, :edit_record, 
                                        rec.id, name: "dnstest2." <> domain_name
         assert is_record(newrec, DigOc.DomainRecord)
         assert newrec.name == "dnstest2." <> domain_name

         # get a record
         a_rec = DigOc.domains domain.id, :records, newrec.id
         assert is_record(a_rec, DigOc.DomainRecord)
         assert a_rec.id == newrec.id

         # destroy a record
         res = DigOc.domains domain.id, :destroy_record, newrec.id
         assert res == :ok

         # destroy domain
         res = DigOc.domains domain.id, :destroy
         assert res == :ok

       end
     end
end
