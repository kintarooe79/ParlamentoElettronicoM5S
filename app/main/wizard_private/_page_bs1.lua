local area_id=param.get("area_id", atom.integer )
local unit_id=param.get("unit_id", atom.integer )

local area_policies=AllowedPolicy:get_policy_by_area_id(area_id)

local dataSource
dataSource = { 
               --{ id = 0, name = _"Please choose a policy" }
        }

if #area_policies>0 then
                       
         for i, allowed_policy in ipairs(area_policies) do
            dataSource[#dataSource+1] = {id=allowed_policy.policy_id }
         end   
 
 trace.debug("dataSource lenght="..#dataSource)                         
 else
                         
end


local page=param.get("page",atom.integer)


local btnBackModule = "wizard_private"
local btnBackView = "wizard_new_initiative_bs"

if not page  or page <= 1 then
    page=1
    btnBackModule ="wizard_private"
    btnBackView = "show_ext_bs"
end

local previus_page=page-1
local next_page=page+1


ui.container{attr={class="row-fluid"},content=function()
  ui.container{attr={class="span12 text-center"},content=function()
    ui.heading{level=3,content=function() 
      slot.put(_"FASE <strong>"..page.."</strong> di 11") 
    end}
    ui.heading{level=4,attr={class="uppercase"},content= _"How much time does your proposal need to be examined?" }
  end }
end }

 

local area_id=param.get("area_id", atom.integer)
local unit_id=param.get("unit_id", atom.integer)

local page=param.get("page",atom.integer)
local wizard=param.get("wizard","table")

local btnBackModule = "wizard_private"
local btnBackView = "wizard_new_initiative"

if not page  or page <= 1 then
    page=1
    btnBackModule ="index"
    btnBackView = "homepage"
end

local previus_page=page-1
local next_page=page+1

 
ui.container{attr={class="row-fluid spaceline2"},content=function()
  ui.container{attr={class="span12 text-center"},content=function()
          --------------------------------------------------------      
         ui.container{attr={class="row-fluid"},content=function()      
           ui.container{attr={class="span12"},content=function()
                    
                     ui.form
                    {
                        method = "post",
                        attr={id="wizardForm"..page, class="inline-block"},
                        module = 'wizard_private',
                        view = 'wizard_new_initiative_bs',
                        params={
                                area_id=area_id,
                                unit_id=unit_id,
                                page=page
                        },
                        routing = {
                            ok = {
                              mode   = 'redirect',
                              module = 'wizard_private',
                              view = 'wizard_new_initiative_bs',
                              params = {
                                           area_id=area_id,
                                           unit_id=unit_id,
                                           page=page
                                          },
                            },
                            error = {
                              mode   = '',
                              module = 'wizard_private',
                              view = 'wizard_new_initiative_bs',
                            }
                          }, 
                       content=function()
                     
                          --parametri in uscita
                        ui.hidden_field{name="indietro" ,value=false}
                        ui.hidden_field{name="policyChooser" ,value=false}
                        ui.hidden_field{name="policy_id" ,value=0}
                        
                       
                           
                        
                        local proposer1
                        local proposer2
                        local proposer3
                        for i,k in ipairs(wizard) do
                          ui.hidden_field{name=k.name ,value=k.value}
                          if k.value then
                          trace.debug("[wizard] name="..k.name.." | value="..k.value)
                          
                          if k.name =="proposer1" then
                          proposer1="true"
                          end
                          
                          if k.name =="proposer2" then
                          proposer2="true"
                          end
                          
                          if k.name =="proposer3" then
                          proposer3="true"
                          end
                          
                          
                          end
                        end
                     
                       ui.container{attr={class="row-fluid spaceline2"},content=function()
                         ui.container{attr={class="span12 text-left"},content=function()

                        --contenuto
 
                                            --1 proposer
                                          execute.view
                                          {
                                              module="wizard_private",
                                              view="_checkbox_bs_pag1",
                                              params={
                                                   imgId=tostring(1),
                                                   id_checkbox=tostring(dataSource[1].id),
                                                   label= Policy:by_id(dataSource[1].id).name
                                                    
                                              }
                                          }
                                          
                                          --2 proposer
                                          execute.view
                                          {
                                              module="wizard_private",
                                              view="_checkbox_bs_pag1",
                                              params={
                                                   imgId=tostring(2),
                                                   id_checkbox=tostring(dataSource[2].id),
                                                   label=Policy:by_id(dataSource[2].id).name
                                                   
                                              }
                                          }
                                          
                                          
                                          --3 proposer
                                          execute.view
                                          {
                                              module="wizard_private",
                                              view="_checkbox_bs_pag1",
                                              params={
                                                   imgId=tostring(3),
                                                   id_checkbox=tostring(dataSource[3].id),
                                                   label=Policy:by_id(dataSource[3].id).name
                                                   
                                                   
                                              }
                                          }
                                                                        
                   --                       end
                    --                      }
                                end }  --fine div contento
                              end }  --fine div contento
                             
                    end            
               }--fine form
            --------------------------------------------------------
             end}
           end} --fine row-fluid
  end }
end }


ui.script{static = "js/wizard_checkbox.js"} 
 

ui.container{attr={class="row-fluid btn_box_bottom spaceline3"},content=function()
  ui.container{attr={class="span12 text-center"},content=function()
    execute.view{
      module="wizard_private",
      view="_pulsanti_bs",
      params={
        btnBackModule = "wizard_private",
        btnBackView = "wizard_new_initiative_bs",
        page=page
      }
    }
  end }
end }
 
