class NestedResourcesController < ResourcesController
  def new
    load_parent
    @object = object_name.classify.constantize.new
  end
  def create
    load_parent
    if @parent
      if @parent.class.method_defined? object_name.pluralize
        @object = @parent.send(object_name.pluralize).build
        params.permit!
        @object.update_attributes(params[object_name])
        @object.employee = current_employee if @object.attributes.has_key? 'employee_id'
        @object.save
      else
        @object = @parent.send("build_#{object_name}")
        params.permit!
        @object.update_attributes(params[object_name])
        @object.employee = current_employee if @object.attributes.has_key? 'employee_id'
        @object.creator = current_employee if @object.attributes.has_key? 'creator_id'
        @object.save
        @parent.save
      end
      redirect_to @parent
    else
      super
    end
  end
  def update
    load_object
    params.permit!
    @object.attributes = params[object_name.singularize.parameterize('_')]
    if @object.changed_for_autosave?
      #@changes = @object.all_changes
      if @object.save
      else
        flash[:error] = @object.errors.full_messages.to_sentence
        @no_log = 1
      end
    end
    if @parent
      redirect_to @parent
    else
      redirect_to @object
    end
  end
  def select
    load_object
  end
  def search
    load_parent
    @collection = Customer.where('name like :pp or mobile like :pp or phone like :pp or email like :pp', { :pp => "%#{params[:q]}%" }).limit(100)
  end

  def load_collection
    load_parent
    if @parent && (@parent.class.method_defined? object_name.pluralize)
      @collection = @parent.send(object_name.pluralize)
    else
      super
    end
  end 
  def load_object
    load_parent
    @object = object_name.classify.constantize.find_by_id(params[:id])
  end
  def load_parent
    parent_id = params.detect {|p| p[0] =~ /^\w+_id$/}
    if parent_id
      @parent_object_name = parent_id[0][0..-4]
      @parent = @parent_object_name.classify.constantize.find(parent_id[1])
    end
  end
end

